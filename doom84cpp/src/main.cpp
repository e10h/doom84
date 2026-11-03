#include "doom/clock.h"
#include "doom/context.h"
#include "doom/engine.h"

int main() {
    auto& context = doom::Context::Instance();
    auto& engine  = doom::Engine::Instance();

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
        context.draw();
    }

    return 0;
}
