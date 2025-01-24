function jpostal() {
    $('#zipcode').jpostal({
      postcode : ['#zipcode'], // 郵便番号の入力欄
      address : {
        '#chat_address': '%3%4%5' // 住所の入力欄
      }
    });
  }
  
  $(document).on("turbolinks:load", jpostal);
  