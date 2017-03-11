# hatebu

Hatebu DSL for RubyPico.

- DSL: Use Ruby to efficiently collect bookmarks
- History: Same URL is not displayed

## Install

1. Setup [RubyPicoGems](https://github.com/rubypico/RubyPicoGems)
2. Run `github_downaload.rb`
3. Download `hatebu`

## Reference
### history(filename, &block)
Set hisotry file path. If `filename` is nil, do not use history.

### show(data)
Show bookmarks and record to history.

```
# Show TOP3 "総合" bookmarks
show category("総合").take(3)
```

### category(name)
Get category bookmarks. Category list is below. 

When hisotry is set, do not return already showed URL.

- "総合"
- "世の中"
- "政治と経済"
- "暮らし"
- "学び"
- "テクノロジー"
- "アニメとゲーム"
- "エンタメ"
- "おもしろ"
- "動画"


### tag(query, opt = {safe: "on"})
Get bookmarks of the specified tag.

```ruby
# Get "ruby" tag bookmarks
tag("ruby")

# Get TOP3 "mruby" tag bookmarks
tag("mrurby").take(3)
```

### title(query, opt = {safe: "on"})
Get bookmarks of the specified title.

### text(query, opt = {safe: "on"})
Get bookmarks of the specified text.

### search(kind, query, opt = {safe: "on"})
kind is "tag" or "title" or "text".

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
