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
        return formIsValid($('#txtName').val(), $('#txtComment').val());
      }
      return true;
    });
    $("#Add").click(function(e){
      if(formIsValid($('#txtName').val(), $('#txtComment').val())){
        self.parent.close_comment_form();  
      }
      else{
        e.preventDefault();
      }
    });
  });
  function formIsValid(name, comment){
    return name && name.length > 0 && name != "Nom" && comment && comment.length > 0 && comment != "Commentaire";
  }
