# DinDinnChallenge Part-2

## OverView
Aim of the project is to build replica of UI -> https://dribbble.com/shots/6571883-Food-Delivery-App/attachments/6571883-Food-Delivery-App?mode=media

General GUI provided is a little confusing and the implementation is as per understanding of given UI

## Architechture
VIPER architecture with little use of MVVM for small resuable views.

### JSON File as a DataSource
A local JSON file acts as a DataSource for the CollectionView with a specified format as follows

```json
[
    {
        "name": "Deluxe",
        "image": "deluxe.jpg",
        "price": 45,
        "type": "pizza",
        "taste": "spicy",
        "details": "Chicken, ham, pepperoni, tomato, sauce, spicy and mozzarella",
        "weight": 150,
        "size": 35
    }
]
```

### Datasource & Gateways
1. JSON file is used as a data fixture
2. Data is fetched locally with out use of any Networking library. If the need arise to fetch data from remote API, we will just have to make another implementation of `FoodListGateway`


### AppFlow with ViewController
App consist of 2 main `UIViewController` i.e `FoodListViewController` & `CartViewController`. `PageViewController` provides sliding functionality to any ViewController which follows the `PagedController` protocol.

### Models
1. `Food` stores different types of food
2. `CartItem` contatins food & qunatity
3. `Cart` is a shared singleton which manages the data of items added to cart. For easiness data is not persisted in DB





