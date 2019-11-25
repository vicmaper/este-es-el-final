var c=1;
window.onload = function(){
		var im1 = "/assets/images/bravo.jpg";
		var im2 = "guerrero.jpg";
		var im3 = "hidalgo.jpg";
		var im4 = "iturbide.jpg";
		var im5 = "matamoros.jpg";
		var im6 = "morelos.jpg";
		document.getElementById("imagen").src = im1;
	
	document.getElementById('anterior').addEventListener("click",function(e){
		e.preventDefault();
		if(c==6){
		c=c-1;
		document.getElementById("imagen").src = im5;
		return;
		}
		if(c==5){
		c=c-1;
		document.getElementById("imagen").src = im4;
		return;
		}	
		if(c==4){
		c=c-1
		document.getElementById("imagen").src = im3;
		return;
		}
		if(c==3){
		c=c-1;
		document.getElementById("imagen").src = im2;
		return;
		}
		if(c==2){
		c=c-1;
		document.getElementById("imagen").src = im1;
		return;
		}
		if(c==1){
		c=6;
		document.getElementById("imagen").src = im6;
		return;
		}
	});
	document.getElementById('siguiente').addEventListener("click",function(e){
		e.preventDefault();
		if(c==6){
		c=1;
		document.getElementById("imagen").src = im1;
		return;
		}
		if(c==5){
		c=c+1;
		document.getElementById("imagen").src = im6;
		return;
		}	
		if(c==4){
		c=c+1
		document.getElementById("imagen").src = im5;
		return;
		}
		if(c==3){
		c=c+1;
		document.getElementById("imagen").src = im4
		return;
		}
		if(c==2){
		c=c+1;
		document.getElementById("imagen").src = im3;
		var nomimg = document.getElementById("nom");
		var tit="tercera imagen";
		areagenerado.innerHTML=tit;
		return;
		}
		if(c==1){
		c=c+1;
		document.getElementById("imagen").src = im2;
		return;
		}
	});
}
