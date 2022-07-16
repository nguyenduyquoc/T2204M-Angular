import { Component } from '@angular/core';
import {IClassroom} from "./interfaces/classroom.interfaces";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'T2204M-Angular';

  classroomArray :IClassroom[]=[
    { classNames :'T2204M' ,classStatus :true},
    { classNames :'T2205M' ,classStatus :false}
  ]
}
