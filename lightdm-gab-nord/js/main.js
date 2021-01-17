var children;
var curr = 1;
var selected_user = null;
var password = null;
var $user = $("#name");
var $pass = $("#login-password");

function show_error()
{
	console.log("error")
}
function show_message(msg)
{
	document.getElementById("login-response").innerHTML = msg;
}

function setup_users_list()
{
	var $list = $user;
    var to_append = null;
    $.each(lightdm.users, function (i) {
        var username = lightdm.users[i].name;
        var dispname = lightdm.users[i].display_name;
        $list.append(
            '<div id="'+username+'">'+dispname+'</div>'
        );
    });
    children = $("#name").children().length;
}

function select_user_from_list(idx, err)
{
	var idx = idx || 0;

	if(!err)
    	find_and_display_user_picture(idx);

    if(lightdm._username){
        lightdm.cancel_authentication();
    }

    selected_user = lightdm.users[idx].name;
    if(selected_user !== null) {
        start_authentication(selected_user);
    }

    $pass.trigger('focus');
}

function start_authentication(username)
{
   lightdm.cancel_timed_login ();
   label = document.getElementById('countdown_label');
   if (label != null)
       label.style.visibility = "false";
	
	selected_user = username;
    lightdm.start_authentication(username);
    
    show_message("?");
}

function authentication_complete()
{
    if (lightdm.is_authenticated)
    	//lightdm.login (lightdm.authentication_user, lightdm.default_session); for lightdm-webkit-greeter
	lightdm.login (lightdm.authentication_user, lightdm.start_session_sync, 'gnome'); //lightdm-webkit2-greeter
    else
   	{
    	select_user_from_list(curr-1, true);
    	show_message ("Wrong password!");
   	}

}

function find_and_display_user_picture(idx, z)
{
 	document.getElementById("login-picture").style.opacity = 0;

    setTimeout(function(){
    	$('#login-picture').attr(
        	'src',
        	lightdm.users[idx].image
    	);
    	document.getElementById("login-picture").addEventListener("load", function(){document.getElementById("login-picture").style.opacity = 1;});
    }, 350);
    
}

function provide_secret()
{
  	password = $pass.val() || null;
  	if(password !== null)
        lightdm.provide_secret(password);
}

function init()
{
    setup_users_list();
    select_user_from_list(0, false);
    show_message ("&nbsp");
    $("#last").on('click', function(e) {
    	curr--;
		if(curr <= 0)
			curr = children;
		if(children != 1) select_user_from_list(curr-1, false);
		$("#name").css("margin-left", -31-(265*(curr-1))+"px");
		show_message("&nbsp");
    });

    $("#next").on('click', function (e) {
    	curr++;
		if(curr > children)
			curr = 1;
		if(children != 1) select_user_from_list(curr-1, false);
		$("#name").css("margin-left", -31-(265*(curr-1))+"px");
		show_message("&nbsp");
    });
}

init();
