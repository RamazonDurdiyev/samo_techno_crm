// ignore_for_file: constant_identifier_names

const String PORT = "https://2e00-195-158-20-242.ngrok-free.app/";

///////// Categories API /////////
const String GET_ALL_CATEGORIES_API =
    "${PORT}product-api/v1/categories/get/all-categories/with-child/product-group";
///////// Products API ///////////
const String GET_PRODUCT_BY_ID =
    "${PORT}product-api/v1/product-group/get/products/by-type-id?typeId=";
const String REMOVE_GET_PRODUCT_BY_ID =
    "${PORT}product-api/v1/in-products/get-all/present/products?typeId=";
const String POST_PRODUCT_API = "${PORT}product-api/v1/in-products/add";
const String FETCH_HISTORIES_API =
    "${PORT}product-api/v1/history/get/all-transactions";
const String FETCH_HISTORY_BY_ID =
    "${PORT}product-api/v1/history/get/all-transactions/";
const String DELETE_PRODUCTS_API = "${PORT}product-api/v1/out-products/sell";
const String GET_UNCONFIRMED_PRODUCTS_API =
    "${PORT}product-api/v1/approve/get/unconfirmed/products";
const String REFRESH_TOKEN_API = "${PORT}api/v1/auth/refresh-token";
const String LOGIN_API = "${PORT}api/v1/auth/log-in";
