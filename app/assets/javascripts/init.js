//参考にしたサイト
//https://freelance-in-six-month.com/tech-blog/rails-materializecss-dropdown-explain/ 

// eventをDOMContentLoaded => turbolinks:loadに変更

document.addEventListener('turbolinks:load', function() {
    var elems = document.querySelectorAll('.dropdown-trigger');
    var options = {
      // coverTriggerをfalseにする
      coverTrigger: false
    };
    M.Dropdown.init(elems, options);

    //モーダルの表示の初期化
    elems = document.querySelectorAll('.modal');
    M.Modal.init(elems, options);

    //タグの機能（Chips）の初期化
    elems = document.querySelectorAll('.chips');
    instances = M.Chips.init(elems, options);
    
    
 
    
});