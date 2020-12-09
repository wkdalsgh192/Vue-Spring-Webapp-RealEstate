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
We set our main color to light pink for better visual convenience. So, tens of logo designs fitted our brans strategy were suggested with the help of Tailer Brands Studio and the current design was finally chosen throguh delicate reviews. Along that, the main page was also changed to the amazing illustration of <b>Gala Poliakova</b>, which looks more natural than just a google-style simple design. She is an great illustrator working for a meditation app company. If you love it, I am 100% sure that her other works would also catch your eyes. Check them out right now on the link. -> https://www.artstation.com/galapoliakova

## Interaction
Static image is not cool any more to attract the young clients' attention. We added some fun interactions for them to think it is so cool that they want to keep using. Among them, the one highlighted here is to show the weather of an user's current location. For example, when it is raining in the place where a user lives and he/she begins typing something on a search bar, it starts raining on our main page, too. For real! Here's how it looks. 
I got a referrence in CodePen and re-created it in VueJs. Please see the link attached if interested. -> https://codepen.io/arickle/pen/XKjMZY  

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
Spring Boot was used for its simple usage and multiple advantages such as autoconfiguration, starter POMs. To make a Spring MVC-based REST application, Spring framework itself is good enough but there are lots of xmls for matching dependencies and configuration. Spring Boot takes away all these pains and lets you write the code that matters, which means that Java development with Spring is very simplified. Among various functions, we would like to show you several key things that must be implemented in a server side to work as a webpage.
## Login / Logout - JWT
Log in/out functions are requisites to make other services and if an user is using our service, his or her id and password must be stored somewhere to remain logged in even when he or she move to a different page. For that, the basic method is to use Cookie and Session. It's way easier to implement and more straightforward than other methods. However, it has a crucial problem called CORS error, which usually occurs when the origin of client is different with that of server. What does it mean? it means that you violated the same-origin policy that restricts how a document or script loaded from one origin can interact with a resource from another origin. If you want to make a Single-Page Application(SPA), you will get the error inevitably because client and server has its own domain respectively. Moreover, you need to consider mobile environments. That's why we used the JWT. 
Unlike using cookie and session, this token-based authentification does not store user's data in neither client nor server. The token created becomes the data as itself and is used in any environment due to the JSON-format communication. Then, how is it created at first? Here's the sample code we wrote.
```java
@RequestMapping(value = "/login", method = RequestMethod.POST)
private ResponseEntity<Map<String, Object>> login(@RequestBody MemberDto member) throws ServletException, IOException {
    Map<String, Object> resultMap = new HashMap<>();
    HttpStatus status = null;
    try {
        MemberDto loginUser = memberService.login(member);
        if(loginUser != null) {
            String token = jwtService.create(loginUser);
            logger.trace("login token info : {}", token);
            resultMap.put("auth-token", token);
            resultMap.put("id", loginUser.getId());
            status = HttpStatus.ACCEPTED;
        }else {
            resultMap.put("message", "로그인 실패");
            status = HttpStatus.ACCEPTED;
        }
    }catch(Exception e) {
        logger.error("Login failed : {}", e);
        resultMap.put("message", e.getMessage());
        status = HttpStatus.INTERNAL_SERVER_ERROR;
    }
    return new ResponseEntity<Map<String, Object>>(resultMap, status);
}
```

# DB : MyBatis & MySql
```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
	"http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.ssafy.happyhouse.model.mapper.HouseMapMapper">
	
	<select id="getDongInGugun" resultType="HashMap" parameterType="string">
	    <![CDATA[SELECT distinct dong, dongcode FROM dongcode WHERE substring(dongcode, 1, 5) = #{gugun} ORDER BY dong]]>
	</select>
	
	<select id="searchApt" resultType="houseinfo" parameterType="String">
		<![CDATA[
		select no, dong, code, info.AptName, jibun, lat, lng, price, area, date 
		from 
			(select AptName, dealAmount price, area, str_to_date(concat(dealYear,"-",dealMonth,"-",dealDay), '%Y-%m-%d') as date 
			from housedeal group by AptName order by date desc) as info 
		inner join 
			(select no, dong, code, AptName, jibun, lat, lng 
			from houseinfo info
			where info.code in (select base.code from baseaddress base where concat(city,' ',gugun,' ',dong) like #{ address })) as deal 
		on info.AptName = deal.AptName;
		]]>
	</select>
	
	<insert id="addLike" parameterType="houselike">
		 <![CDATA[insert into interestarea (id, apt_name, price, area, last_update) values (#{id}, #{apt_name}, #{price}, #{area}, #{last_update});]]>
	</insert>
	
	<select id="checkPrice" resultType="housedeal" parameterType="String">
		<![CDATA[select no, dong, AptName apt_name, dealAmount deal_amount, date_format(str_to_date(concat(dealYear,'-',dealMonth,'-',dealDay), '%Y-%m-%d'), '%m-%d') as deal_date 
		from housedeal where AptName = #{AptName} order by deal_date;]]>
	</select>
</mapper>
```



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
