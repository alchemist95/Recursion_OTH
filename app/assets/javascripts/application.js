// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require toastr_rails



$(document).ready(function() {

	$("#myAnswer").click(function(event){
		event.preventDefault();
		console.log("Idhar");		
	 	$.ajax({
	 		type: 'POST',
	 		url: '/abdv',
	 		dataType: "json",
	 		data: {"myAnswer" : $("#myAnswerText").val()},
	 		success: function(data){
				if (data["Score"] == -1){
					$("#myResult").html("<script>toastr['error']('Incorrect Answer');</script>");
				}
				else if(data["Statement"] == "XXX"){
					var myScore = data["Score"];
					var myLevel = myScore/10 + 1;
					$("#myScore").text(myScore);
					$("#hunt").hide();
					$("#myResult").html("<script>toastr['info']('Your Hunt ends!! :)');</script>");
					location.href = '/victory'
				}
				else{
					var statement = data["Statement"];
					var image = data["Image"];
					var myScore = data["Score"];
					var myLevel = myScore/10 + 1;
					var h2 = $("#myQuestion").find("span");
					$("#myImage").hide();
					$(h2).html(statement);
					$("#myImage").append('<span><img src=\"/images/'+image+'\"></span>');
					$("#myScore").text(myScore);
					$("#myLevel").text(myLevel);
					$("#myResult").html("<script>toastr['info']('Correct Answer. Level Up!!');</script>");
				}
				document.getElementById("answerForm").reset();
	 		},
	 		error: function(){
	 			alert("Failure!");
	 		}
	 	})
	 });
});
