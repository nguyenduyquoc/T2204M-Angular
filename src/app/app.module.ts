import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppComponent } from './app.component';
import {StudentComponent} from "./student/student.component";
import {ClassroomComponent} from "./classroom/classroom.component";
import {FormsModule} from "@angular/forms";
import {CurrentweatherComponent} from "./currentweather/currentweather.component";
import {HttpClientModule} from "@angular/common/http";
import {Currentweather2Component} from "./currentweather2/currentweather2.component";
import {Router, RouterModule, Routes} from "@angular/router";
import {aboutusComponent} from "./aboutus/aboutus.component";
import {loginComponent} from "./login/login.component";
import {registerComponent} from "./Register/register.component";


const appRouters: Routes = [
  {path: '',component:CurrentweatherComponent},
  {path: 'about-us',component: aboutusComponent},
  {path: 'log-in',component: loginComponent},
  {path: 'register',component: registerComponent},

];

@NgModule({
  declarations: [
    AppComponent,
    StudentComponent,
    ClassroomComponent,
    CurrentweatherComponent,
    Currentweather2Component,
    aboutusComponent,
    loginComponent,
    registerComponent
  ],
  imports: [
    BrowserModule,FormsModule,
    HttpClientModule,
    RouterModule.forRoot(appRouters)
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
