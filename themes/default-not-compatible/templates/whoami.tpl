<table width="100%" border="0" cellspacing="1" cellpadding="0">
  <tr bgcolor="#E9E9E9"> 
    <td>{$LNG_department}</td>
    <td>{$LNG_staffIdTitle} - {$LNG_nameSurname}</td>
    <td>{$LNG_envOS}</td>
    <td>{$LNG_date}</td>
  </tr>
  <tr bgcolor="#F7F7F7"> 
    <td> <strong>      {$userData.staff_type} </strong></td>
    <td> <strong> {$userData.staff_name} {$userData.staff_surname}      </strong></td>
    <td>{$userEnvironment.platform}    	
    </td>
    <td>{$smarty.now|date_format}</td>
  </tr>
</table>