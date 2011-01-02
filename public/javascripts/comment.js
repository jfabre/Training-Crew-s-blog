$(document).ready(function(){
    $("#txtName, #txtComment").focus(function(){
        if(this && this.value){
          if(this.value == 'Nom' || this.value == 'Commentaire')
            this.value = '';
        }
    });
    $("#txtName").blur(function(){
      if(this && this.value == ''){
        this.value = 'Nom';
      }
    });
    $("#txtComment").blur(function(){
      var obj = $(this);
      if(obj.val() == ''){
        obj.val('Commentaire');
      }
    });
    
    $("#txtName").keypress(function(e) {
      var code = e.keyCode ? e.keyCode : e.which;
      if (code == 13){
        var txtName = $('#txtName');
        var txtComment = $('#txtComment');
        if(txtName.val() != '' && txtName != 'Nom' && txtComment.val() != '' && txtComment.val() != 'Commentaire'){
          return true;
        }
        return false;
      }
      return true;
    });
    $("#Add").click(function(){
      self.parent.close_comment_form();
    });
  });