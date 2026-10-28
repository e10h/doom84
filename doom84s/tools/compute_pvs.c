#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>

#define MAX(a,b) ((a)>(b)?(a):(b))
#define MIN(a,b) ((a)<(b)?(a):(b))

typedef struct __attribute__((packed)) { int16_t x,y; } Vertex;
typedef struct __attribute__((packed)) { uint16_t v1,v2,flags,special,tag,side[2]; } Line;
typedef struct __attribute__((packed)) { int16_t x,y; uint8_t upper,lower,middle,sector; } Side;
typedef struct __attribute__((packed)) { int16_t floor,ceiling; uint8_t flat,ceiltex,light,special,tag,pad; } Sector;

static Vertex vertices[467];
static Line lines[475];
static Side sides[648];
static Sector sectors[85];

static bool sight(int x,int y,int tx,int ty,int eye) {
    int dx=tx-x,dy=ty-y;
    for (unsigned i=0;i<475;++i) {
        const Line *l=&lines[i];
        const Vertex *a=&vertices[l->v1],*b=&vertices[l->v2];
        if (MAX(x,tx)<MIN(a->x,b->x) || MIN(x,tx)>MAX(a->x,b->x) || MAX(y,ty)<MIN(a->y,b->y) || MIN(y,ty)>MAX(a->y,b->y)) continue;
        if (l->side[1]!=65535u) {
            unsigned sa=sides[l->side[0]].sector,sb=sides[l->side[1]].sector;
            if (eye>MAX(sectors[sa].floor,sectors[sb].floor) && eye<MIN(sectors[sa].ceiling,sectors[sb].ceiling)) continue;
        }
        int32_t c1=(int32_t)(a->x-x)*dy-(int32_t)(a->y-y)*dx;
        int32_t c2=(int32_t)(b->x-x)*dy-(int32_t)(b->y-y)*dx;
        int32_t c3=(int32_t)(x-a->x)*(b->y-a->y)-(int32_t)(y-a->y)*(b->x-a->x);
        int32_t c4=(int32_t)(tx-a->x)*(b->y-a->y)-(int32_t)(ty-a->y)*(b->x-a->x);
        if ((c1<0)!=(c2<0) && (c3<0)!=(c4<0)) return false;
    }
    return true;
}

int main(void) {
    FILE *f=fopen("doom84s/build/D84MAP.bin","rb");
    if(!f){perror("fopen");return 1;}
    fseek(f,16,SEEK_SET);
    fread(vertices,sizeof(Vertex),467,f);
    fseek(f,1884,SEEK_SET);
    fread(lines,sizeof(Line),475,f);
    fseek(f,8534,SEEK_SET);
    fread(sides,sizeof(Side),648,f);
    fseek(f,13718,SEEK_SET);
    fread(sectors,sizeof(Sector),85,f);
    fclose(f);

    uint8_t pvs[85][11];
    memset(pvs,0,sizeof(pvs));

    /* Sector sample points: line centers nudged into each sector */
    int num_points[85];
    int pt_x[85][64], pt_y[85][64];
    memset(num_points,0,sizeof(num_points));

    for (unsigned i=0;i<475;++i) {
        const Line *l=&lines[i];
        const Vertex *a=&vertices[l->v1],*b=&vertices[l->v2];
        int dx=b->x-a->x,dy=b->y-a->y;
        double len=hypot(dx,dy);
        if(!len) continue;
        int mx=(a->x+b->x)/2,my=(a->y+b->y)/2;
        int nx=(int)lround(dy*8/len),ny=(int)lround(-dx*8/len);

        unsigned s0=sides[l->side[0]].sector;
        if(num_points[s0]<64) {
            pt_x[s0][num_points[s0]]=mx+nx;
            pt_y[s0][num_points[s0]]=my+ny;
            num_points[s0]++;
        }
        if(l->side[1]!=65535u) {
            unsigned s1=sides[l->side[1]].sector;
            if(num_points[s1]<64) {
                pt_x[s1][num_points[s1]]=mx-nx;
                pt_y[s1][num_points[s1]]=my-ny;
                num_points[s1]++;
            }
        }
    }

    /* Self-visibility and portal neighbor visibility */
    for(unsigned s=0;s<85;++s) {
        pvs[s][s>>3]|=(1<<(s&7));
    }
    for (unsigned i=0;i<475;++i) {
        const Line *l=&lines[i];
        if(l->side[1]!=65535u) {
            unsigned sa=sides[l->side[0]].sector,sb=sides[l->side[1]].sector;
            pvs[sa][sb>>3]|=(1<<(sb&7));
            pvs[sb][sa>>3]|=(1<<(sa&7));
        }
    }

    /* Ray testing between all sector sample pairs */
    for(unsigned s1=0;s1<85;++s1) {
        for(unsigned s2=s1+1;s2<85;++s2) {
            bool visible=false;
            for(int i=0;i<num_points[s1] && !visible;++i) {
                int x1=pt_x[s1][i],y1=pt_y[s1][i];
                int eye1=sectors[s1].floor+41;
                for(int j=0;j<num_points[s2];++j) {
                    int x2=pt_x[s2][j],y2=pt_y[s2][j];
                    if(sight(x1,y1,x2,y2,eye1) || sight(x1,y1,x2,y2,sectors[s2].floor+41)) {
                        visible=true;
                        break;
                    }
                }
            }
            if(visible) {
                pvs[s1][s2>>3]|=(1<<(s2&7));
                pvs[s2][s1>>3]|=(1<<(s1&7));
            }
        }
    }

    /* Count visible vs culled pairs */
    unsigned total_visible=0;
    for(unsigned s1=0;s1<85;++s1) {
        for(unsigned s2=0;s2<85;++s2) {
            if((pvs[s1][s2>>3]>>(s2&7))&1) total_visible++;
        }
    }
    printf("Total sector pairs: 85x85 = 7225\n");
    printf("Potentially visible pairs: %u (%.1f%%)\n",total_visible,(double)total_visible*100.0/7225.0);
    printf("Pruned/culled pairs: %u (%.1f%%)\n",7225-total_visible,100.0-(double)total_visible*100.0/7225.0);

    /* Output src/pvs.h */
    FILE *out=fopen("doom84s/src/pvs.h","w");
    if(out) {
        fprintf(out,"/* Generated 85x11 PVS table for E1M1 (935 bytes). */\n");
        fprintf(out,"#ifndef D84_PVS_H\n#define D84_PVS_H\n\n");
        fprintf(out,"static const uint8_t pvs_table[85][11] = {\n");
        for(unsigned s1=0;s1<85;++s1) {
            fprintf(out,"    {");
            for(unsigned b=0;b<11;++b) {
                fprintf(out,"0x%02x%s",pvs[s1][b],b<10?",":"");
            }
            fprintf(out,"}%s\n",s1<84?",":"");
        }
        fprintf(out,"};\n\n#endif\n");
        fclose(out);
        printf("Wrote doom84s/src/pvs.h successfully.\n");
    }

    return 0;
}
