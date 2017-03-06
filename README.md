# hatebu

Hatebu DSL for RubyPico.

## Sample

```ruby
require "hatebu/dsl"

history_file = File.join(Dir.documents, "hatebu", ".hatebu_history")

history(history_file) do
  case rand(100)
  when 0..29
    show category("総合").take(4)
    c = ["テクノロジー", "アニメとゲーム"]
    show category(c.sample).take(3)
    show category("動画").take(2)
  when 30..59
    show tag("ruby").take(3)
    show tag("mruby").take(3)
    show text("docker").take(3)
  when 60..89
    show tag("mac").take(3)
    show title("airpods").take(3)
    show title("airpods", sort: "popular").take(3)
  else
    show category("世の中").take(2)
    show category("政治と経済").take(2)
    show category("暮らし").take(2)
    show category("エンタメ").take(2)
    show category("おもしろ").take(2)
  end
end
```
