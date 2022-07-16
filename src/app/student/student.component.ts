import {Component, Input} from "@angular/core";
import {IStudent} from "../interfaces/student.interfaces";
import {IClassroom} from "../interfaces/classroom.interfaces";

@Component({
  selector:'app-student',
  //template:'<h1>Day la component cua Student</h1><h2>motconvit</h2>'
  templateUrl:'./student.component.html'
})
export class StudentComponent {
  @Input()
  data!:IStudent;

}
