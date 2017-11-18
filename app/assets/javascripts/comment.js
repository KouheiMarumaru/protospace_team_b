$(function(){
  function buildHTML(comment){
    var html = `<p class="addComment">
                  <strong>
                    <a href=${comment.id}>${comment.user_name}</a>
                    ：
                  </strong>
                  ${comment.text}
                </p>
                <button id="deleteButton">
                  Delete
                <button>
                <button id="editButton">
                  Edit
                <button>
                `
    return html;
  }
  //コメント追加
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = window.location.href + '/comments'
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comments').append(html)
      $('.textbox').val('')
    })
    .fail(function(){
      alert('error');
    })
  })
  //コメント削除
  $(document).on('click', "#deleteButton", function(){
    console.log("deleteがクリックされました");
    $(".addComment").remove();
    $("#deleteButton").remove();
    $("#editButton").remove();
  })

});
