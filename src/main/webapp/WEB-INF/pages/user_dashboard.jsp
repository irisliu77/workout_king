<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>User Dashboard</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,700" rel="stylesheet">
    <!-- Bulma Version 0.8.x-->
    <link rel="stylesheet" href="/node_modules/bulma/css/bulma.css" />
    <link rel="stylesheet" type="text/css" href="/css/admin.css">
</head>

<body>

<!-- START NAV -->
<jsp:include page="../../../resources/static/header.html"/>
<!-- END NAV -->
<div class="container">
    <div class="columns">
        <div class="column is-3 ">
            <!-- START MENU-->
            <jsp:include page="../../../resources/static/menu.html"/>
            <!-- END MENU-->
        </div>
        <div class="column is-9">
            <section class="hero is-info welcome is-small">
                <div class="hero-body">
                    <div class="container">
                        <h1 class="title">
                            Hello, <span id="userName">Unknown User</span>
                        </h1>
                        <h2 class="subtitle" id="userMotto"></h2>
                    </div>
                </div>
            </section>
            <section class="info-tiles">
                <p class="subtitle">Your intake summary on <span class="day"></span>:</p>
                <div class="tile is-ancestor has-text-centered">
                    <div class="tile is-parent">
                        <article class="tile is-child box">
                            <p class="title"><span id="todayCalories">0</span>kcal</p>
                            <p class="subtitle">Calories</p>
                        </article>
                    </div>
                    <div class="tile is-parent">
                        <article class="tile is-child box">
                            <p class="title"><span id="todayProtein">0</span>g</p>
                            <p class="subtitle">Protein</p>
                        </article>
                    </div>
                    <div class="tile is-parent">
                        <article class="tile is-child box">
                            <p class="title"><span id="todayCarbohydrate">0</span>g</p>
                            <p class="subtitle">Carbohydrate</p>
                        </article>
                    </div>
                    <div class="tile is-parent">
                        <article class="tile is-child box">
                            <p class="title"><span id="todayFat">0</span>g</p>
                            <p class="subtitle">Fat</p>
                        </article>
                    </div>
                </div>
                <p class="subtitle">What you ate on <span class="day"></span>:</p>
                <div class="tile is-ancestor has-text-centered" id="dayDiets">
                    <!--
                    <div class="tile is-parent">
                        <article class="tile is-child box">
                            <p class="title">Lunch</p>
                            <p class="subtitle">300(ml) Milk, 1(g) Apple</p>
                        </article>
                    </div>
                    -->
                </div>
            </section>
            <section class="card events-card">
                <header class="card-header">
                    <p class="card-header-title">
                        Diet History
                    </p>
                    <!--
                    <a href="#" class="card-header-icon" aria-label="more options">
                        <span class="icon">
                            <i class="fa fa-angle-down" aria-hidden="true"></i>
                        </span>
                    </a>
                    -->
                </header>
                <div class="card-table">
                    <div class="content">
                        <table class="table is-fullwidth is-striped">
                            <tbody id="tbodyIntakes"></tbody>
                        </table>
                    </div>
                </div>
                <footer class="card-footer">
                    <a href="#" class="card-footer-item">Prev</a>&nbsp;&nbsp;&nbsp;<a href="#" class="card-footer-item">Next</a>
                </footer>
            </section>
        </div>
    </div>
</div>
<script async type="text/javascript" src="/js/bulma.js"></script>
<script type="text/javascript" src="/js/register.js"></script>
<script type="text/javascript" src="/js/user.js"></script>
<script type="text/javascript" src="/node_modules/jquery/dist/jquery.js"></script>
<script type="text/javascript" src="/node_modules/axios/dist/axios.js"></script>
</body>
<script>
    let user = null;
    let deleteIntake = function(iid){
        alert(iid);
    }
    let showDetail = function(i){
        $('#dayDiets').html("");
        $('.day').html(user.intakes[i].date);
        $('#todayCalories').html(user.intakes[i].calories);
        $('#todayFat').html(user.intakes[i].fat);
        $('#todayProtein').html(user.intakes[i].protein);
        $('#todayCarbohydrate').html(user.intakes[i].carbohydrate);
        for(let j=0;j<user.intakes[i].intakes.length;j++){
            let html = "";
            for(let k=0;k<user.intakes[i].intakes[j].diets.length;k++){
                html += user.intakes[i].intakes[j].diets[k].amount
                html += user.intakes[i].intakes[j].diets[k].unit
                html += "&nbsp;"
                html += user.intakes[i].intakes[j].diets[k].food
                html += ";&nbsp;"
            }
            $('#dayDiets').append(`<div class="tile is-parent">
                        <article class="tile is-child box">
                            <span class="title">`+user.intakes[i].intakes[j].description+`</span><br>
                            <span class="subtitle has-text-black">`+html+`</span><br>
                            <span class="has-text-grey">Calories `+user.intakes[i].intakes[j].calories+`kcal</span><br>
                            <span class="has-text-grey">Protein `+user.intakes[i].intakes[j].protein+`g</span><br>
                            <span class="has-text-grey">Carbohydrate `+user.intakes[i].intakes[j].carbohydrate+`g</span><br>
                            <span class="has-text-grey">Fat `+user.intakes[i].intakes[j].fat+`g</span><br>
                            <a onclick="deleteIntake(`+user.intakes[i].intakes[j].iid+`)">Delete</a>
                        </article>
                    </div>`)
        }
    }

    $('.dashboard').addClass("is-active");

    $(async function(){
        let data = await getInfo();
        user = data.data;
        console.log(user);

        $('#userName').html(user.name);
        $('#userMotto').html(user.motto);
        showDetail(0);
        for(let i=0;i<user.intakes.length;i++){
            $('#tbodyIntakes').append(`<tr>
                                    <td width="5%"><i class="fa fa-bell-o"></i></td>
                                    <td>`+user.intakes[i].date+`</td>
                                    <td class="level-right"><a class="button is-small is-primary" onclick="showDetail(`+i+`);">View</a></td>
                                </tr>`)
        }
    })
</script>
</html>
