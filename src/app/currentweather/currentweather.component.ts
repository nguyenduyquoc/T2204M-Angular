import {Component} from "@angular/core";
import {ICurrentweather} from "../interfaces/currentweather.interfaces";
import {HttpClient, HttpParams} from "@angular/common/http";

@Component({
  selector: 'app-currentweather',
  templateUrl:'./currentweather.component.html'
})
export class CurrentweatherComponent {
  data: ICurrentweather | undefined;
  cityCode = 'Hanoi';
  constructor(private http: HttpClient) {//hàm này tự động chạy sau khi tạo component
  }

  ngOnInit(){//hàm này tự động chạy sau khi print html xong
   this.changeCity();
  }
  changeCity() {
    const url = 'https://api.openweathermap.org/data/2.5/weather';
    let parrams = new HttpParams();
    parrams = parrams.append('q',this.cityCode)
    parrams = parrams.append('appid','09a71427c59d38d6a34f89b47d75975c')
    parrams = parrams.append('units','metric')
    this.http.get<ICurrentweather>(url,{params: parrams})
      .subscribe(value=>{
        this.data = value;
      })
  }

}
