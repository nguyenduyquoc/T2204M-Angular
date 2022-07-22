import {Component, Input} from "@angular/core";
import {IStudent} from "../interfaces/student.interfaces";
import {IClassroom} from "../interfaces/classroom.interfaces";

@Component({
  selector:'app-classroom',
  templateUrl:'./classroom.component.html'
})
export class ClassroomComponent {
  @Input()
  data!:IClassroom;


  //Tạo một danh sách sinh viên
  studentArray: IStudent[] = [
    {studentName:'Hoàng Duy Quốc', studentAge:21, phoneNumber:'0962027042'},
    {studentName:'Nguyễn Phương Ngân', studentAge:18, phoneNumber:'0962028052'},
    {studentName:'Một con vịt', studentAge:20, phoneNumber:'0964728052'},
  ]

  teacherNames = [
    'Hoàng Duy Quốc',
    'Nguyễn Phương Ngân',
    'Một Con Lợn',
    'Hai Con lợn',
    'Ba Con Bò'
  ];
  subjectNames = [
    'LBEP',
    'HCJS',
    'AJS',
    'DMS'
  ];

  changeName(){
    this.data.classNames = 'T2203E';
  }
  changeStatus(){
    this.data.classStatus = !this.data.classStatus;
  }
}
