// doom84cpp - e10h
// porting doom to modern cpp for the calc
#include "doom/clock.h"
#include "doom/context.h"
#include "doom/engine.h"

int main() {
    doom::Context& context = doom::Context::Instance();
    doom::Engine& engine   = doom::Engine::Instance();

    // make sure archive appvars are sent
    if (!context.init() || !engine.init()) {
        context.show_alert(
            "E1M1 assets missing,\n"
            "unarchived or outdated.\n"
            "Send ALL D84*.8xv\n"
            "files to Archive.\n"
            "Press any key."
        );
        return 1;
    }

    doom::Clock clock;
    while (!context.should_close()) {
        float dt = clock.restart();

        context.update();
        engine.update(dt);
        engine.render();
        context.draw(); // flip double buffer
    }

    // exit cleanly back to ti-os
    return 0;
}
