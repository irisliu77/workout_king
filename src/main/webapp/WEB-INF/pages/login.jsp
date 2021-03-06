<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link href="https://fonts.googleapis.com/css?family=Questrial&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/node_modules/bulma/css/bulma.css" />
    <link rel="stylesheet" type="text/css" href="/css/login.css">
</head>

<body>
<section class="hero is-success is-fullheight">
    <div class="hero-body">
        <div class="container has-text-centered">
            <div class="column is-4 is-offset-4">
                <h3 class="title has-text-black">Login</h3>
                <hr class="login-hr">
                <p class="subtitle has-text-black">Please login to proceed.</p>
                <div class="box">
                    <figure class="avatar">
                        <img src="https://placehold.it/128x128">
                    </figure>
                    <div>
                        <div class="field">
                            <div class="control">
                                <input id="inputEmail" class="input is-large" type="email" placeholder="Your Email" autofocus="">
                            </div>
                        </div>

                        <div class="field">
                            <div class="control">
                                <input id="inputPassword" class="input is-large" type="password" placeholder="Your Password">
                            </div>
                        </div>
                        <button id="buttonLogin" class="button is-block is-info is-large is-fullwidth">Login <i class="fa fa-sign-in" aria-hidden="true"></i></button>
                    </div>
                </div>
                <p class="has-text-grey">
                    <a href="/signup">Sign Up</a> &nbsp;|&nbsp; <a href="/forget">Forgot Password</a>
                </p>
            </div>
        </div>
    </div>
</section>
<script async type="text/javascript" src="/js/bulma.js"></script>
<script type="text/javascript" src="/js/register.js"></script>
<script type="text/javascript" src="/node_modules/jquery/dist/jquery.js"></script>
<script type="text/javascript" src="/node_modules/axios/dist/axios.js"></script>
</body>
<script>
    $('#buttonSignup').on('click',function(){
        location.href = 'signup';
    })
    $('#buttonLogin').on('click',function(){
        let email = $('#inputEmail').val();
        let password = $('#inputPassword').val();
        if(!isValidEmail(email)){
            alert('Email not valid');
            return false;
        }
        if(password.length<8){
            alert('Password not valid');
            return false;
        }
        login(email,password).then(res=>{
            console.log(res)
            if(!res.data){
                alert("Your email and password don't match in our database");
                return;
            }
            location.href="/user/dashboard"
        }).catch(err=>{
            console.log(err);
        })
    })
</script>

</html>