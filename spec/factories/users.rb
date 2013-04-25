FactoryGirl.define do
  factory :user do
    sequence(:nickname) {|n| "person#{n}" }
    email { "#{nickname}@example.com".downcase }
    bio   "<p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras viverra purus eget lectus adipiscing faucibus. Suspendisse vehicula, sapien ut accumsan facilisis, dui nunc elementum nulla, vel pretium ante risus non leo. Nullam rutrum suscipit orci. Aliquam at augue ac nulla eleifend eleifend a nec lorem. Maecenas rhoncus odio ac magna egestas ultrices. Integer tristique aliquam auctor. Pellentesque eget nisi tortor. Ut accumsan, enim ut facilisis adipiscing, libero neque sodales mi, eget sagittis metus justo nec nunc. Suspendisse potenti. Curabitur iaculis tortor lobortis nunc eleifend scelerisque.
          </p>
          <p>
          Etiam elementum risus sit amet nisl fringilla ullamcorper. Maecenas ac vestibulum tellus. Phasellus consectetur eros in neque volutpat scelerisque. Cras vestibulum tristique interdum. Nunc in erat nulla, id auctor dolor. Suspendisse congue congue arcu a scelerisque. Donec fringilla vehicula feugiat. Sed ac interdum risus. Nam non leo libero. Curabitur condimentum, tortor nec ultricies fermentum, urna magna fringilla sapien, vitae sollicitudin ipsum ligula a nisi. Duis id posuere leo.
          </p>
          <p>
          Nullam ligula enim, euismod quis pellentesque quis, porttitor varius dolor. Nullam ultrices fringilla magna. Ut ligula ante, ornare vitae tincidunt tempus, consectetur id nulla. Nam aliquet, dolor quis ornare ultrices, urna elit auctor turpis, eget convallis libero nibh vitae nisi. Suspendisse non tortor libero, et consectetur lacus. Donec malesuada auctor varius. Pellentesque convallis hendrerit arcu, at elementum eros commodo a. Mauris tortor velit, porttitor quis tristique quis, dignissim at turpis. Duis dignissim tempor diam a faucibus. Quisque enim enim, scelerisque vel adipiscing ac, fermentum non libero. Nullam ligula magna, mollis at congue at, iaculis non ligula. Mauris sagittis porttitor fringilla. Nam pharetra neque quis nulla egestas pharetra. Nulla blandit, sapien a feugiat gravida, mi libero vestibulum nisl, sed varius odio est et nisl.
          </p>
          <p>
          Vestibulum mi nibh, consectetur ut viverra id, tincidunt sed diam. Donec at lorem urna. Sed in magna mi. Nulla facilisis commodo mauris eget vulputate. Nulla nec posuere libero. Duis et mauris et ante feugiat venenatis. Donec justo diam, scelerisque at ornare at, hendrerit vitae nibh. Mauris non lobortis nibh.
          </p>
          <p>
          Nunc viverra sollicitudin nisl tristique luctus. Sed at scelerisque purus. Pellentesque dapibus pellentesque massa vel varius. Nam id fringilla metus. Nulla vehicula gravida mollis. In consequat interdum lacinia. Ut cursus quam ut sem pretium eu ornare purus vulputate. Etiam a ligula pharetra velit bibendum suscipit. Fusce vel nulla diam. Suspendisse potenti.
          </p>"
    password "password"
  end
end