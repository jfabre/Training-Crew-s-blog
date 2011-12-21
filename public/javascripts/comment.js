 function removeCaption(){
    if(this && this.value){
      if(this.value == 'Nom' || this.value == 'Commentaire')
        this.value = '';
    }
  }
  function formIsValid(name, comment){
    return name && name.length > 0 && name != "Nom" && comment && comment.length > 0 && comment != "Commentaire";
  }

function setupForm(name, comment){
  if(name.val() == ''){
    name.val('Nom');
  }  
  name.focus(removeCaption)
    .blur(function(){
      if(this && this.value == ''){
        this.value = 'Nom';
      }
  }).keypress(function(e) {
    var code = e.keyCode ? e.keyCode : e.which;
    if (code == 13){
      return formIsValid(name.val(), name.val());
    }
    return true;
  });
  
  comment.val('Commentaire')
    .focus(removeCaption)
    .blur(function(){
      var obj = $(this);
      if(obj.val() == ''){
        obj.val('Commentaire');
      }
  });
  
  $("input[type=submit]").click(function(e){
    if(formIsValid(name.val(), comment.val())){
      self.parent.close_comment_form();  
    }
    else{
      e.preventDefault();
    }
  });
}
  
 