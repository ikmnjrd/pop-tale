//参考にしたサイト
//https://freelance-in-six-month.com/tech-blog/rails-materializecss-dropdown-explain/ 

// eventをDOMContentLoaded => turbolinks:loadに変更
// 一度しか表示されない不具合を確認したのでturbolinks削除 => DOMContentLoaded に変更

document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.dropdown-trigger');
    var options = {
      // coverTriggerをfalseにする
      coverTrigger: false
    };
    dropdonwn_menu = M.Dropdown.init(elems, options);

    //モーダルの表示の初期化
    modal_elems = document.querySelectorAll('.modal');
    M.Modal.init(modal_elems, {});

    //タグの機能（Chips）の初期化
    chips_elems = document.querySelectorAll('.chips');
    instances = M.Chips.init(chips_elems, {});
    
});