# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    title "Lorem Ipsum Dolor Sit Amet"
    keywords "lorem, ipsum, dolor, sit, amet"
    description "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non leo sagittis urna gravida mollis. Integer non felis diam. Ut at orci et neque ullamcorper porta semper sit amet orci. Sed fringilla magna ut urna eleifend sit amet fringilla velit mollis. Vestibulum pretium, nisl sed facilisis tempus, ligula justo molestie justo, quis egestas mauris nunc in ligula. Integer placerat auctor consectetur. Mauris id ligula nunc, sed pharetra nisl."
    body "<p>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non leo sagittis urna gravida mollis. Integer non felis diam. Ut at orci et neque ullamcorper porta semper sit amet orci. Sed fringilla magna ut urna eleifend sit amet fringilla velit mollis. Vestibulum pretium, nisl sed facilisis tempus, ligula justo molestie justo, quis egestas mauris nunc in ligula. Integer placerat auctor consectetur. Mauris id ligula nunc, sed pharetra nisl.
          </p>
          <p>
          Sed egestas mattis nunc, a semper nulla accumsan vitae. Sed in erat erat, vitae pretium lorem. Vestibulum sagittis, turpis at egestas fermentum, risus quam iaculis nisl, sed iaculis leo arcu vel magna. In ac ullamcorper turpis. Nulla luctus consequat dictum. Etiam volutpat sapien nec lacus mollis aliquet. Nunc rhoncus risus id ipsum euismod ac fermentum metus varius. Pellentesque vitae ligula purus. Pellentesque gravida pharetra nisl nec pretium. Etiam nec magna sed ante aliquam auctor.
          </p>
          <p>
          Cras iaculis sapien sit amet magna ullamcorper sed iaculis enim imperdiet. In ultrices lorem sed magna porttitor porta. Proin ut hendrerit sapien. Ut nunc nisl, suscipit eget posuere vel, laoreet ornare nisi. Quisque commodo molestie massa, eu hendrerit ligula consequat a. Praesent at varius eros. Phasellus vitae neque eu neque facilisis feugiat. Praesent laoreet, lacus vel laoreet volutpat, lectus leo eleifend odio, id ultricies ante purus id sapien. Duis vel congue magna. Vestibulum felis arcu, vehicula at ultrices eu, volutpat eget lorem.
          </p>
          <p>
          Nunc et consequat ante. Nulla facilisi. Aenean egestas justo vel eros facilisis pharetra consectetur in turpis. Vivamus ornare ultricies orci, eu eleifend dui fermentum tempor. Vestibulum nulla sapien, aliquam vel venenatis in, tempor vitae enim. Nunc vehicula, lectus quis dictum euismod, lectus lorem volutpat nulla, ac congue risus tellus nec augue. Morbi convallis, nulla vel sollicitudin lobortis, sapien tellus mattis turpis, id pulvinar tortor metus eu sem. Duis rhoncus gravida diam non posuere. Etiam varius elit eu ante varius hendrerit. Duis eget ipsum nulla. Cras bibendum, quam vitae ullamcorper eleifend, sapien odio suscipit odio, sed tristique diam arcu nec sapien. Suspendisse eget est ante. Sed tincidunt iaculis tristique.
          </p>
          <p>
          Quisque risus enim, ultricies sed porttitor et, ullamcorper in ipsum. Vestibulum id sapien tortor, quis pulvinar odio. Vivamus pulvinar lectus ut felis feugiat in tincidunt libero pellentesque. Aliquam erat volutpat. Sed at purus eu diam tincidunt vehicula. Nulla facilisi. Duis a purus diam. Donec in dui nec lorem tempor placerat quis in eros. In pellentesque ipsum quis leo commodo sed adipiscing diam rhoncus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sagittis vulputate leo vel pellentesque. Praesent pretium scelerisque felis. Etiam hendrerit ultricies magna, quis semper odio ultrices nec. Etiam tempus dapibus dui a fermentum.
          </p>"
    public true
    parent_id nil
  end
end
