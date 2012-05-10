function hilite(id, Cls) {
	x=document.getElementById(id);
	if (x.className==Cls) {
		x.className='';
	} else {
		x.className=Cls;
	}
	return;
}


function hiliteNew(id, classOne, classTwo) {
	x=document.getElementById(id);
	//alert (x)
	//alert(x.className)

	if (x.className == classOne) {
		switchClass(id, classTwo)
	} else if (x.className == classTwo) {
		switchClass(id, classOne)
	} else {
		//alert(222)
		//x.className = classTwo;
	}
	return;
}



function switchClass(id, Cls) {
	x=document.getElementById(id);
//		alert(id)
//		alert('old class'+x.className)
//		alert('new class'+Cls)
	x.className=Cls;
	return;
}

function unHilite(id) {
	document.getElementById(id).className='';
	return;
}


function updateElement(id, string) {
	x=document.getElementById(id);
	x.value=string;
	return;
}

function toggleCheckBoxes(cbGroup, cbAllObj, currentClass, newClass) {
	  var groupName = document.getElementsByName(cbGroup);

	  for (i = 0; i < groupName.length; i++) {
	  	groupName[i].checked = cbAllObj.checked? true:false
		  	if ( (currentClass != '') && (newClass != '') ) {
			  	var trRow = groupName[i].parentNode.parentNode;
		  		trRow.className = (cbAllObj.checked) ? newClass : currentClass;
		  	}
	  }

}


/* */


function openDebugPopupWindow() {
	window.open('popup.php?do=errors', 'Debug Window', 'status=1,width="+scr_wd+",height=500,scrollbars=yes,resizable=yes');
	//winName.focus();
}
function openPopupWindow(theURL,winName,features) {
	window.open(theURL,winName,features);
	//winName.focus();
}

function confirmUri(msg) {
	if(!msg) msg = "Are you sure?";
	if(confirm(msg)) return true;
	else return false;
}

/*
//window.onload = function changeRowClassOnMouseOver(tableName) {//
window.onload = function () {
	var t = document.getElementsByTagName('table');

	for(i=0;i<t.length;i++) {
		if (t[i].className != 'standard' || t[i].id=='pass') continue;
		var rows = t[i].getElementsByTagName("tr");

		for(j=0;j<rows.length;j++){
			if (rows[j].id != 'pass') {
				rows[j].onmouseover = new Function("this.className='rowOnMouseOver';");
				rows[j].onmouseout  = new Function("this.className='" + rows[j].className + "';");
			}
		}
	}
}
*/

function changeRowClassOnMouseOverLoaded(tableId, rowCurrentClass, rowNewClass) {

	var t = document.getElementById(tableId);

	var rows = t.getElementsByTagName("tr");

		for(j=0;j<rows.length;j++){
			if (rows[j].id != 'pass') {
				rows[j].onmouseover = new Function("this.className='" + rowNewClass + "';");
				rows[j].onmouseout  = new Function("this.className='" + rows[j].className + "';");
			}
		}
}

function changeRowClass(rowId, checkBoxId, rowNewClass, rowCheckedClass) {
	var row = document.getElementById(rowId);
	var box = document.getElementById(checkBoxId);

	if (row.id != 'pass') {
		newClass = rowNewClass;
		if ( (box.checked) && (rowCheckedClass != '') ) {
			newClass = rowCheckedClass;
		}
		row.className= newClass;
	}
}

function switchColors(x) {
    var obj = document.getElementById(x);
    if (obj.style.backgroundColor == 'yellow') {
        obj.style.backgroundColor =  'white';
    } else {
        obj.style.backgroundColor =  'yellow';
    }

}
function switchClasses(id, currentClass, newClass) {
    var obj = document.getElementById(id);
	alert(obj.style.className)
    if (obj.style.className == currentClass) {
        obj.style.className =  newClass;
    } else {
        obj.style.className =  currentClass;
    }

}

function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      if (oldonload) {
        oldonload();
      }
      func();
    }
  }
}

function switchHideShowLayers(id) {
	var obj = document.getElementById(id);
	//alert(obj.style.display);
	if (obj.style.display=='none') {
		obj.style.display='block';
	} else {
		obj.style.display='none';
	}
}

function getImgNewSrc(imgId, url) {
	var xImgObj = document.getElementById(imgId);
	xImgObj.src = url;

}
function focusOnField(id) {
	var x = document.getElementById(id);
	x.focus();
}

function changeProject(obj, urlString) {
	var xObj = document.getElementById(obj);

	if (xObj.value == '') {
		return false;
	}

	var newURL = urlString + xObj.value;
	window.location.href = newURL;
	return false;
}



/* AJAX LOADING BAR AND MESSAGE DIV-> JS FUNCTIONS STARTS*/
	function getScrollTop() {
		if ( document.documentElement.scrollTop ) {
			return document.documentElement.scrollTop;
		}
		return document.body.scrollTop;
	}

	function scrollHandler() {
	var e = document.getElementById('rc_notify');
	e.style.top = getScrollTop();
	}

	function showNotify( str ) {
		var x = document.getElementById('rc_notify');
		x.style.display = 'block';
		x.style.visibility = 'visible';

		if ( x.currentStyle && x.currentStyle.position == 'absolute' ) {
			x.style.top = getScrollTop();
			window.onscroll = scrollHandler;
		}
		//alert(str)
		x.innerHTML = str;
	}

	function hideNotify() {
		var x = document.getElementById('rc_notify');
		x.style.display = 'none';
		x.style.visibility = 'hidden';
		window.onscroll = null;
	}
/* AJAX LOADING BAR AND MESSAGE DIV-> JS FUNCTIONS ENDS*/