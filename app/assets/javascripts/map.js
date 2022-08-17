let map

          const display = document.getElementById('display')

          // mapの表示関数
          function initMap() {
              geocoder = new google.maps.Geocoder()

              // mapの初期位置, 縮尺を定義
              map = new google.maps.Map(document.getElementById('map'), {
                  center: {lat: <%= @post.latitude %>, lng: <%= @post.longitude %>},
                  zoom: 12,
              });

              // mapsテーブルにあるそれぞれのレコードをmap上に表示

                  (function(){
                  var contentString = "住所：<%= @post.address %>";

                  // マーカーを立てる
                  var marker = new google.maps.Marker({
                      position:{lat: <%= @post.latitude %>, lng: <%= @post.longitude %>},
                      map: map,
                      title: contentString
                  });

                  // 情報ウィンドウ(吹き出し)の定義
                  // 投稿の詳細ページへのリンクも
                  var infowindow = new google.maps.InfoWindow({
                  position: {lat: <%= @post.latitude %>, lng: <%= @post.longitude %>},
                  content: "<a href='<%= post_path(@post.id) %>' target='_blank'><%= @post.title %><br><%= @post.body %></a>"
                  });

                  // クリックしたときに情報ウィンドウを表示
                  marker.addListener('click', function() {
                  infowindow.open(map, marker);
                  });

                  })();

          }

          let geocoder

          // 地図検索関数
          function codeAddress() {
              let inputAddress = document.getElementById('address').value;

              geocoder.geocode({
                  'address': inputAddress
              }, function (results, status) {
                  if (status == 'OK') {
                      map.setCenter(results[0].geometry.location);
                      var marker = new google.maps.Marker({
                          map: map,
                          position: results[0].geometry.location
                      });

                  display.textContent = "検索結果：" + results[ 0 ].geometry.location
                  } else {
                      alert('該当する結果がありませんでした：' + status);
                  }
              });
          }