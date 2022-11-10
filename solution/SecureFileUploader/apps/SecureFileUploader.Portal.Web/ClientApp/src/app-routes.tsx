import React from "react";
import {Route, Routes} from "react-router-dom";
import {ProgramsRoutes} from "./pages/programs/programs-routes";
import {Settings} from "./pages/settings/settings";
import {Home} from "./pages/home";

export function AppRoutes(): JSX.Element {
    return (
        <Routes>
            <Route path="/*" element={<Home/>}/>
            <Route path="/programs/*" element={<ProgramsRoutes/>}/>
            <Route path="/settings" element={<Settings/>}/>
        </Routes>
    );
}
