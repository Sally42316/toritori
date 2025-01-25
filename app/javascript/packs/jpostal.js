function jpostal() {
    $('#postal_code').jpostal({
      postcode : ['#postal_code'],
      address : {
        '#address': '%3%4%5'
      }
    });
  }
  $(document).on("turbolinks:load", jpostal);