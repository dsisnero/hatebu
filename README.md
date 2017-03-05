# hatebu

Hatebu DSL for RubyPico.

## Sample

```ruby
require "hatebu/dsl"

history_file = File.join(Dir.documents, "hatebu", ".hatebu_history")

history(history_file) do
  case rand(100)
  when 0..70
    puts "通常"
    show category("総合").take(4)
    c = ["テクノロジー", "アニメとゲーム"]
    show category(c.sample).take(3)
    show category("動画").take(2)
  when 71..80
    puts "政治"
    show category("政治と経済").take(3)
    show category("世の中").take(3)
    show category("暮らし").take(3)
  else
    puts "全カテゴリTOP"
    show category("総合").take(1)
    show category("世の中").take(1)
    show category("政治と経済").take(1)
    show category("暮らし").take(1)
    show category("アニメとゲーム").take(1)
    show category("エンタメ").take(1)
    show category("おもしろ").take(1)
    show category("動画").take(1)
  end
end
```
