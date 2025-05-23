# Create directories if they don't exist
New-Item -ItemType Directory -Force -Path "assets/Diabetic-Friendly"
New-Item -ItemType Directory -Force -Path "assets/Lactose-Free"

# Copy files from original directories to the new ones with proper naming
# Diabetic Friendly
Copy-Item "assets/Diabetic Friendly/Additional - Boiled Corn.png" -Destination "assets/Diabetic-Friendly/DF-Boiled-Corn.png"
Copy-Item "assets/Diabetic Friendly/Additional - Boiled Peanuts.png" -Destination "assets/Diabetic-Friendly/DF-Boiled-Peanuts.png"
Copy-Item "assets/Diabetic Friendly/Additional - Fruit Slices.png" -Destination "assets/Diabetic-Friendly/DF-Fruit-Slices.png"
Copy-Item "assets/Diabetic Friendly/Additional - Low-carb Pichi-Pichi.png" -Destination "assets/Diabetic-Friendly/DF-Low-Carb-Pichi-Pichi.png"
Copy-Item "assets/Diabetic Friendly/Additional - Oat Balls (unsweetened).png" -Destination "assets/Diabetic-Friendly/DF-Oat-Balls.png"
Copy-Item "assets/Diabetic Friendly/Boiled Kamote_Saba + egg.png" -Destination "assets/Diabetic-Friendly/DF-Boiled-Kamote-Saba.png"
Copy-Item "assets/Diabetic Friendly/Dinner offer - Chicken Inasal.png" -Destination "assets/Diabetic-Friendly/DF-Chicken-Inasal.png"
Copy-Item "assets/Diabetic Friendly/Dinner offer - Chopsuey w_ Lean Pork.png" -Destination "assets/Diabetic-Friendly/DF-Chopsuey-Lean-Pork.png"
Copy-Item "assets/Diabetic Friendly/Dinner offer - Mongo + Malunggay + Egg.png" -Destination "assets/Diabetic-Friendly/DF-Mongo-Malunggay-Egg.png"
Copy-Item "assets/Diabetic Friendly/Dinner offer - Pesang Isda.png" -Destination "assets/Diabetic-Friendly/DF-Pesang-Isda.png"
Copy-Item "assets/Diabetic Friendly/Dinner offer - Tofu + Ampalaya Stir-fry.png" -Destination "assets/Diabetic-Friendly/DF-Tofu-Ampalaya-Stir-Fry.png"
Copy-Item "assets/Diabetic Friendly/Drinks - Lemongrass Water.png" -Destination "assets/Diabetic-Friendly/DF-Lemongrass-Water.png"
Copy-Item "assets/Diabetic Friendly/Drinks - Low-sugar Buko Juice.png" -Destination "assets/Diabetic-Friendly/DF-Low-Sugar-Buko-Juice.png"
Copy-Item "assets/Diabetic Friendly/Drinks - Pandan Tea.png" -Destination "assets/Diabetic-Friendly/DF-Pandan-Tea.png"
Copy-Item "assets/Diabetic Friendly/Drinks - Salabat w_ Stevia.png" -Destination "assets/Diabetic-Friendly/DF-Salabat-Stevia.png"
Copy-Item "assets/Diabetic Friendly/Drinks - Unsweetened Soy Milk.png" -Destination "assets/Diabetic-Friendly/DF-Unsweetened-Soy-Milk.png"
Copy-Item "assets/Diabetic Friendly/Lunch offer - Chicken Tinola w_ Sayote.png" -Destination "assets/Diabetic-Friendly/DF-Chicken-Tinola-Sayote.png"
Copy-Item "assets/Diabetic Friendly/Lunch offer - Grilled Fish + Ensaladang Talong.png" -Destination "assets/Diabetic-Friendly/DF-Grilled-Fish-Talong.png"
Copy-Item "assets/Diabetic Friendly/Lunch offer - Kalabasa + Malunggay + Tofu.png" -Destination "assets/Diabetic-Friendly/DF-Kalabasa-Malunggay-Tofu.png"
Copy-Item "assets/Diabetic Friendly/Lunch offer - Laing w_ Brown Rice.png" -Destination "assets/Diabetic-Friendly/DF-Laing-Brown-Rice.png"
Copy-Item "assets/Diabetic Friendly/Lunch offer - Sinampalukang Manok.png" -Destination "assets/Diabetic-Friendly/DF-Sinampalukang-Manok.png"
Copy-Item "assets/Diabetic Friendly/Morning offer - Ampalaya Omelette.png" -Destination "assets/Diabetic-Friendly/DF-Ampalaya-Omelette.png"
Copy-Item "assets/Diabetic Friendly/Morning offer - Lugaw with egg.png" -Destination "assets/Diabetic-Friendly/DF-Lugaw-Egg.png"
Copy-Item "assets/Diabetic Friendly/Morning offer - Oatmeal Champorado.png" -Destination "assets/Diabetic-Friendly/DF-Oatmeal-Champorado.png"
Copy-Item "assets/Diabetic Friendly/Morning offer - Rice + Tofu + Sitaw.png" -Destination "assets/Diabetic-Friendly/DF-Rice-Tofu-Sitaw.png"

# Lactose Free
Copy-Item "assets/Lactose Free/Additional - Banana-cue (no caramel).png" -Destination "assets/Lactose-Free/LF-Banana-Cue.png"
Copy-Item "assets/Lactose Free/Additional - Boiled Cassava.png" -Destination "assets/Lactose-Free/LF-Boiled-Cassava.png"
Copy-Item "assets/Lactose Free/Additional - Fresh Lumpia.png" -Destination "assets/Lactose-Free/LF-Fresh-Lumpia.png"
Copy-Item "assets/Lactose Free/Additional - Kalamay (no dairy).png" -Destination "assets/Lactose-Free/LF-Kalamay.png"
Copy-Item "assets/Lactose Free/Additional - Rice Cakes.png" -Destination "assets/Lactose-Free/LF-Rice-Cakes.png"
Copy-Item "assets/Lactose Free/Dinner Offer - Adobong Kangkong + Tofu.png" -Destination "assets/Lactose-Free/LF-Adobong-Kangkong-Tofu.png"
Copy-Item "assets/Lactose Free/Dinner Offer - Laing (Dairy free).png" -Destination "assets/Lactose-Free/LF-Laing.png"
Copy-Item "assets/Lactose Free/Dinner Offer - Mongo Guisado + Malunggay.png" -Destination "assets/Lactose-Free/LF-Mongo-Guisado-Malunggay.png"
Copy-Item "assets/Lactose Free/Dinner Offer - Stir-fried Gabi + Pechay.png" -Destination "assets/Lactose-Free/LF-Stir-Fried-Gabi-Pechay.png"
Copy-Item "assets/Lactose Free/Dinner Offer - Tuna Lumpia.png" -Destination "assets/Lactose-Free/LF-Tuna-Lumpia.png"
Copy-Item "assets/Lactose Free/Drinks - Almond Milk Brew.png" -Destination "assets/Lactose-Free/LF-Almond-Milk-Brew.png"
Copy-Item "assets/Lactose Free/Drinks - Coconut Water.png" -Destination "assets/Lactose-Free/LF-Coconut-Water.png"
Copy-Item "assets/Lactose Free/Drinks - Rice Milk Smoothie.png" -Destination "assets/Lactose-Free/LF-Rice-Milk-Smoothie.png"
Copy-Item "assets/Lactose Free/Drinks - Salabat.png" -Destination "assets/Lactose-Free/LF-Salabat.png"
Copy-Item "assets/Lactose Free/Drinks - Soy-based Taho.png" -Destination "assets/Lactose-Free/LF-Soy-Taho.png"
Copy-Item "assets/Lactose Free/Lunch Offer - Chicken Adobo (no dairy).png" -Destination "assets/Lactose-Free/LF-Chicken-Adobo.png"
Copy-Item "assets/Lactose Free/Lunch Offer - Ginisang Upo w_ Chicken.png" -Destination "assets/Lactose-Free/LF-Ginisang-Upo-Chicken.png"
Copy-Item "assets/Lactose Free/Lunch Offer - Inihaw na Tilapia + Ensaladang Mangga.png" -Destination "assets/Lactose-Free/LF-Inihaw-Tilapia-Mangga.png"
Copy-Item "assets/Lactose Free/Lunch Offer - Paksiw na Bangus.png" -Destination "assets/Lactose-Free/LF-Paksiw-Bangus.png"
Copy-Item "assets/Lactose Free/Lunch Offer - Pork Sinigang.png" -Destination "assets/Lactose-Free/LF-Pork-Sinigang.png"
Copy-Item "assets/Lactose Free/Morning offer - Arroz Caldo.png" -Destination "assets/Lactose-Free/LF-Arroz-Caldo.png"
Copy-Item "assets/Lactose Free/Morning offer - Boiled Saba + Peanut Butter.png" -Destination "assets/Lactose-Free/LF-Boiled-Saba-Peanut-Butter.png"
Copy-Item "assets/Lactose Free/Morning offer - Ginisang Ampalaya w_ Egg.png" -Destination "assets/Lactose-Free/LF-Ginisang-Ampalaya-Egg.png"
Copy-Item "assets/Lactose Free/Morning offer - Soy Milk w_ Banana.png" -Destination "assets/Lactose-Free/LF-Soy-Milk-Banana.png"
Copy-Item "assets/Lactose Free/Morning offer - Tortang Talong.png" -Destination "assets/Lactose-Free/LF-Tortang-Talong.png"

Write-Host "Files renamed successfully!" 