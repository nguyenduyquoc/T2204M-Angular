import {Component} from "@angular/core";
import {ICurrentweather2} from "../interfaces/currentweather2.interfaces";
import {HttpClient, HttpParams} from "@angular/common/http";


@Component({
  selector: 'app-currentweather2',
  templateUrl: './currentweather2.component.html'
})
export class Currentweather2Component {
  data: ICurrentweather2 | undefined;
  cityCode = 'Hanoi';
  constructor(private http: HttpClient) {//hàm này tự động chạy sau khi tạo component
  }
  ngOnInit(){
    this.changeCity();
  }
  changeCity(){
    const url = 'http://api.openweathermap.org/data/2.5/forecast';
    let parrams = new HttpParams();
    parrams = parrams.append('q',this.cityCode)
    parrams = parrams.append('appid','09a71427c59d38d6a34f89b47d75975c')
    parrams = parrams.append('units','metric')
    this.http.get<ICurrentweather2>(url,{params: parrams})
      .subscribe(value => {
        this.data = value;
      })
  }

}


