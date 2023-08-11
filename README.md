# Turbo Stream - the AJAX of rails
### Step by step implementation. Thanks to [@Deanin](https://github.com/Deanout)

## 1- Generate a Rails app with Devise
App generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.
```
rails new \
  -d postgresql \
  -m https://raw.githubusercontent.com/lewagon/rails-templates/master/devise.rb \
  turbo-refresh
  ```

## 2- Add a counter columnto the User table
- Generate file
```
rails generate migration add_counter_to_users counter:integer
```
- Set default value of counter to 0
```
add_column :users, :counter, :integer, default: 0
```
- ```rails db:migrate```

## 3- Implement the whole counter incrementation process (without turbo stream)
- routes.rb:
  ```
  get "upvote", to: "pages#upvote"
  ```
- pages_controller.rb:
  ```
   def upvote
    current_user.increment!(:counter)
    redirect_to root_path
  end
  ```
- home.html.erb
  ```
  <%= link_to "Upvote", upvote_path, class: "btn btn-primary" %>
  <%= render "pages/counter", counter: current_user.counter %>
  ```
- partial: _counter.html.erb
  ```
    <h1>Upvotes: <%= counter %></h1>
  ```

## 4- Implement the counter incrementation WITH TURBO STREAM
#### Modify the 2 following existing files

- pages_controller.rb:
  ```
    def upvote
    current_user.increment!(:counter)
    render_counter
  end

  private

  def render_counter
    render turbo_stream:
      turbo_stream.replace(
        "counter",
        partial: "pages/counter",
        locals: { counter: current_user.counter }
      )
  end
  ```
- partial: _counter.html.erb
  ```
  <%= turbo_frame_tag "counter" do %>
    <h1>Upvotes: <%= counter %></h1>
  <% end %>
  ```
