/*sample usage:

function checkWholeForm(theForm) {
    var why = "";
    why += checkEmail(theForm.email.value);
    why += checkPhone(theForm.phone.value);
    why += checkPassword(theForm.password.value);
    why += checkUsername(theForm.username.value);
    why += isEmpty(theForm.notempty.value);
    why += isDifferent(theForm.different.value);
    for (i=0, n=theForm.radios.length; i<n; i++) {
        if (theForm.radios[i].checked) {
            var checkvalue = theForm.radios[i].value;
            break;
        }
    }
    why += checkRadio(checkvalue);
    why += checkDropdown(theForm.choose.selectedIndex);
    if (why != "") {
       alert(why);
       return false;
    }
return true;
}
*/
function trim(str) {
  return str.replace(/^\s+|\s+$/g, '')
};

function get_element(fieldname,fieldtitle) {
	var x = document.getElementById(fieldname);
	return x;
}

// email

// Copyright © 2001 by Apple Computer, Inc., All Rights Reserved.
//
// You may incorporate this Apple sample code into your own code
// without restriction. This Apple sample code has been provided "AS IS"
// and the responsibility for its operation is yours. You may redistribute
// this code, but you are not permitted to redistribute it as
// "Apple sample code" after having made changes.

// email

function checkEmail (fieldname, fieldtitle, errorMsgEmpty, errorMsgInvalid) {
	var error="";
	x = get_element(fieldname);
	xvalue = trim(x.value);

	if (xvalue == "") {
	   error = "["+fieldtitle+"] "+ errorMsgEmpty + "\n";
	}

    var emailFilter=/^.+@.+\..{2,3}$/;
    var illegalChars= /[\(\)\<\>\,\;\:\\\"\[\]]/

	//test email for illegal characters and email format
    if ( (!(emailFilter.test(xvalue))) || (xvalue.match(illegalChars)) ) {
       error = "["+fieldtitle+"] "+ errorMsgInvalid + "\n";
    }
	return error;
}


// phone number - strip out delimiters and check for 10 digits

function checkPhone (fieldname, fieldtitle, fieldlen, errorMsgEmpty, errorMsgNonZeroStart, errorMsgInvalid, errorMsgLen) {
	var error = "";
	x = get_element(fieldname);
	strng = trim(x.value);

	if (strng == "") {
	   error = "["+fieldtitle+"] "+ errorMsgEmpty + "\n";
	}

	if (strng.charAt(0) == "0") {
	   error = "["+fieldtitle+"] "+ errorMsgNonZeroStart + "\n";
	}


	var stripped = strng.replace(/[\(\)\.\-\ ]/g, ''); //strip out acceptable non-numeric characters
    if (isNaN(parseInt(stripped))) {
       error = "["+fieldtitle+"] "+ errorMsgInvalid + "\n";

    }
    if (!(stripped.length == fieldlen)) {
		error = "["+fieldtitle+"] "+ errorMsgLen + fieldlen + "\n";
    }
	return error;
}


// password - between 6-8 chars, uppercase, lowercase, and numeral

function checkPassword (fieldname, fieldtitle, errorMsgEmpty,  errorMsgLen,  errorMsgInvalid) {

	var error = "";
	x = get_element(fieldname);
	strng = trim(x.value);

	if (strng == "") {
	   error = "["+fieldtitle+"] "+ errorMsgEmpty + "\n";
	}

    var illegalChars = /[\W_]/; // allow only letters and numbers

    if ((strng.length < 6) || (strng.length > 8)) {
       error = "["+fieldtitle+"] "+ errorMsgLen + "\n";
    }
    else if (illegalChars.test(strng)) {
      error = "["+fieldtitle+"] "+ errorMsgInvalid + "\n";
    }
//    else if (!((strng.search(/(a-z)+/)) && (strng.search(/(A-Z)+/)) && (strng.search(/(0-9)+/)))) {
//       error = "["+fieldtitle+"] ?ifre en az bir büyük, bir küçük ve bir rakam içermelidir.\n";
//    }
	return error;
}


// username - 4-10 chars, uc, lc, and underscore only.

function checkUsername (fieldname, fieldtitle, errorMsgEmpty,  errorMsgLen,  errorMsgInvalid) {

	var error = "";
	x = get_element(fieldname);
	strng = trim(x.value);

	if (strng == "") {
	   error = "["+fieldtitle+"] "+ errorMsgEmpty + "\n";
	}


    var illegalChars = /\W/; // allow letters, numbers, and underscores
    if ((strng.length < 4) || (strng.length > 10)) {
       error = "["+fieldtitle+"] "+ errorMsgLen + "\n";
    }
    else if (illegalChars.test(strng)) {
    error = "["+fieldtitle+"] "+ errorMsgInvalid + "\n";
    }
	return error;
}

// was textbox altered

function isDifferent(fieldname, fieldtitle, errorMsg) {
	var error = "";
	x = get_element(fieldname);
	strng = trim(x.value);

  if (strng != "Can\'t touch this!") {
     error = "You altered the inviolate text area.\n";
  }
	return error;
}

// exactly one radio button is chosen

function checkRadio(checkvalue, fieldtitle, errorMsg) {
	var error = "";

   if (!(checkvalue)) {
       error = "["+fieldtitle+"] "+ errorMsg + "\n";
    }
	return error;
}

// valid selector from dropdown list

function checkDropdown(fieldname, fieldtitle, errorMsg) {
	var error = "";
	x = get_element(fieldname);
	//alert(x.value);
	choice = x.value;
	//choice = x.options[x.selectedIndex].value;
	//alert(choice);

    if ((choice == 0) || (choice == '') || (choice == null)) {
	    error = "["+fieldtitle+"] "+ errorMsg + "\n";
		x.style.background='lightyellow';
	    //setfocus(x);
    }
	return error;
}

function isNumeric(fieldname,fieldtitle, errorMsg) {
   //var ValidChars = "0123456789.";//noktalari da kabul eder ondalik sayilar icin..
   var ValidChars = "0123456789";
   var error = "";
   var Char;

   x = get_element(fieldname);
   string= x.value;


   for (i = 0; i < string.length && error == ""; i++) {
      Char = string.charAt(i);
      if (ValidChars.indexOf(Char) == -1) {
			error = "["+fieldtitle+"] "+ errorMsg + "\n";
         }
      }
   return error;
}

// non-empty textbox
function isEmpty(fieldname, fieldtitle, errorMsg) {
	var error = "";
	x = get_element(fieldname);
	xvalue = trim(x.value);

	if ((xvalue==0) || (xvalue==null) || (xvalue=="")) {
		error = "["+fieldtitle+"] "+ errorMsg + "\n";
		x.style.background='lightyellow';
	    //setfocus(string);
	}
	return error;
}


var glb_vfld;      // retain vfld for timer thread

function setFocusDelayed() {
  glb_vfld.focus()
}

function setfocus(vfld) {
  // save vfld in global variable so value retained when routine exits
  glb_vfld = vfld;
  setTimeout( 'setFocusDelayed()', 100 );
}
