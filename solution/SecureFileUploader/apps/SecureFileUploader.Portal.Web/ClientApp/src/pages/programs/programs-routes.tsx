import React from "react";
import {Navigate, Route, Routes} from "react-router-dom";
import {ListPrograms} from "./list";
import {CreateProgram} from "./create";
import {EditProgram} from "./edit";
import {LoadingPage} from "../../components/pages/loading-page/loading-page";

export function ProgramsRoutes(): JSX.Element {
    return (
        <React.Suspense fallback={<LoadingPage/>}>
            <Routes>
                <Route path="/*" element={<Navigate to="list"/>}/>
                <Route path="/list" element={<ListPrograms/>}/>
                <Route path="/create" element={<CreateProgram/>}/>
                <Route path="/:id/" element={<EditProgram/>}/>
            </Routes>
        </React.Suspense>
    );
}
