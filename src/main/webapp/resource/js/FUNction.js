/**
 * Created by hawky on 15/12/5.
 */

$.extend({getEname:function (textField) {
    $.ajax({
        url: "/wisdom",
        type: "GET",
        contentType: "application/x-www-form-urlencoded; charset=utf-8",
        success: function (e) {
            var obj = JSON.parse(JSON.parse(e));
            var re = obj.data[0].disp_data[0].ename+"——"+obj.data[0].disp_data[0].author;
            textField.text(re);
            console.log(re);
        }
    });
}});





