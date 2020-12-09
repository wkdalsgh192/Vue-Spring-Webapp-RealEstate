<p align="center">
    <img width="450" align="center" src="https://user-images.githubusercontent.com/50606172/101280995-e4400d80-380f-11eb-94f4-e0f527c643ff.png" alt="demo"/>
</p>


# Happy House
[![Contributors][contributors-shield]][contributors-url] [![Forks][forks-shield]][forks-url] [![Stargazers][stars-shield]][stars-url] [![Issues][issues-shield]][issues-url] [![MIT License][license-shield]][license-url]

# Table of Contents
- Service Introduction
- UI/UX Design
- Frontend : Vue
  - RESTful API
  - Kakao Platform API
- Backend :Spring Boot
  - JWT
- DB : MySql
  
# Service Introduction
Happy House, which is an online real estate agent platform, was created by two young and talented Korean developers in December 2020. At the target of young generation who wants to be cool and hip, this has been made to provide them the most useful experience in looking for various kinds of studios, apartments that they would live in. For that, expectation and anxiety that come from a new living place were set as main keywords that we should deal with in our website. In other words, we wanted them to be more hopeful and less nervous by our numerous services. Because it is a prototype, it will not get updated unless there are major issues. If you have any questions, please shoot an email to deakse2@gmail.com.
<p align="center">
    <img width="800" align="center" src="https://user-images.githubusercontent.com/50606172/101655344-dba43d00-3a84-11eb-9358-7a3943edcc5c.gif"/>
 </p>

# UI/UX
## Design
We set our main color to light pink for better visual convenience. So, tens of logo designs fitted our brans strategy were suggested with the help of Tailer Brands Studio and the current design was finally chosen throguh delicate reviews. Along that, the main page was also changed to the amazing illustration of <b>Gala Poliakova</b>, which looks more natural than just a google-style simple design. She is an great illustrator working for a meditation app company. If you love it, I am 100% sure that her other works would also catch your eyes. Check them out right now on the link. // 링크 들어가는 부분

## Interaction
Static image is not cool any more to attract the young clients' attention. We added some fun interactions for them to think it is so cool that they want to keep using. Among them, the one highlighted here is to show the weather of an user's current location. For example, when it is raining in the place where a user lives and he/she begins typing something on a search bar, it starts raining on our main page, too. For real! Here's how it looks. 
// 이미지 들어가는 부분

I got a referrence in CodePen and re-created it in VueJs. Please see the link attached if interested.  

# Frontend : Vue
  We used the Vue framwork for frontend. Before that, we made web pages to .jsp, that was totally undesiable since all the html and css codes were mingled with java codes. After the installation of Vue CLI, however, we could make our messy files and codes well-organized. 

## Restful API
We used RESTful API through Vue Axios to exchange JSON type data. Mainly, client requested to server to call a list of houses located in the address that users typed on a search bar. Here's the one sample code we used.
``` javascript
Axios
    .get("http://localhost:8000/happyhouse/heart/search")
    .then((response) => {
      this.items = response.data;

      // change data to charts
      let obj = new Object(),
          labels = new Array(),
          data = new Array();
      response.data.forEach((elem) => {
        labels.push(elem['dong']);
        data.push(elem['cnt']);
      })
      obj.labels = labels;
      obj.data = data;
      this.chart = obj;
    })
    .catch(() =>{
      alert("error occured");
    })
```

## Kakao Platform API (Geolocation API)
In order to show users where the places are located, we used Kakao Map API, which is way convenient in terms of customizing and pricing than Google Map API. It provides various types of libraries for users to be able to add directly on the map rendered. They can add/remove markers and move map by drag to find other area. Calling the Vue instace in the event listener was very sticky since whenever 'this' keyword was called on console, it indicated the event listener, not the instance, due to the asynchronous communication. For that, I used some tricks; <b> that : this, Promise </b>
```javascript
let latlng = null;
let geocoder = new kakao.maps.services.Geocoder();
let that = this; // Super Important!!!!
kakao.maps.event.addListener(map, 'dragend', function() {
    latlng = map.getCenter();

    const addressSearch = latlng => {
        return new Promise((resolve, reject) => {
            geocoder.coord2RegionCode(latlng.getLng(), latlng.getLat(), function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    resolve(result);
                } else reject(status);
            });
        })
    }
    (async () => {
        try {
            const result = await addressSearch(latlng);
           for (let index = 0; index < result.length; index++) {
                if (result[index].region_type === 'H') {
                    let si = result[index].region_1depth_name,
                        gugun = result[index].region_2depth_name,
                        dong = result[index].region_3depth_name;
                    let arr = dong.split("");
                    for (let j = 0; j < arr.length; j++) {
                        if (isNaN(arr[j])) continue;
                        arr.splice(j)
                        dong = arr.join('')
                    }
                    let newAddress = si+" "+gugun+" "+dong;
                    that.keyword = newAddress;
                    that.getKeyword("");
                    break;
                }
            }  
        } catch(e) {
            console.log(e);
        }
    })();
})
```

# Backend : Spring Boot
## Login


## Project setup
```
npm install
```

### Compiles and hot-reloads for development
```
npm run serve
```

### Compiles and minifies for production
```
npm run build
```

### Lints and fixes files
```
npm run lint
```

### Customize configuration
See [Configuration Reference](https://cli.vuejs.org/config/).


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/wkdalsgh192/evaranks.svg?style=flat-square
[contributors-url]: https://github.com/wkdalsgh192/evaranks/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/wkdalsgh192/evaranks.svg?style=flat-square
[forks-url]: https://github.com/wkdalsgh192/evaranks/network/members
[stars-shield]: https://img.shields.io/github/stars/wkdalsgh192/evaranks.svg?style=flat-square
[stars-url]: https://github.com/wkdalsgh192/evaranks/stargazers
[issues-shield]: https://img.shields.io/github/issues/wkdalsgh192/evaranks.svg?style=flat-square
[issues-url]: https://github.com/wkdalsgh192/evaranks/issues
[license-shield]: https://img.shields.io/github/license/wkdalsgh192/evaranks.svg?style=flat-square
[license-url]: https://github.com/wkdalsgh192/evaranks/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=flat-square&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/wkdalsgh192
[product-screenshot]: images/screenshot.png
