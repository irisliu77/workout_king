let  getCalories = function(ingredients){
    return axios({
        method: 'post',
        url: 'https://api.edamam.com/api/nutrition-details',
        params: {
            app_id: 'c653bc23',
            app_key: '39063867d27088781fb1b31772bc5a3d'
        },
        data: {
            ingr: ingredients//["1 apple","1 beef steak"]
        }
    })
}

let addRecordToDatabase = function(description,calories,fat,carbohydrate,protein,diets){
    //console.log([description,calories,fat,carbohydrate,protein,diets])
    return axios({
        method: 'post',
        url: '/api/user/intake',
        params: {
            description: description,
            calories: calories,
            fat: fat,
            carbohydrate: carbohydrate,
            protein: protein
        },
        data: diets
    })
}

let addJSONRecordToDatabase = function(doc){
    return axios({
        method: 'post',
        url: '/api/user/intake_json',
        data: doc
    })
}