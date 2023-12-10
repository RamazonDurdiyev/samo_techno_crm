// ignore_for_file: constant_identifier_names

const String BASE_URL = "https://0b54-82-215-104-42.ngrok-free.app/";

///////// Time outs ///////////

const int CONNECT_TIME_OUT = 30000;
const int SEND_TIME_OUT = 30000;
const int RECEIVE_TIME_OUT = 30000;

///////// Categories API /////////
const String GET_ALL_CATEGORIES_API = "${BASE_URL}v1/categories/all";
///////// Products API ///////////
const String GET_PRODUCT_BY_ID = "${BASE_URL}v1/products/";
const String REMOVE_GET_PRODUCT_BY_ID =
    "${BASE_URL}v1/in-products/all?parentId=";
const String POST_PRODUCT_API = "${BASE_URL}v1/in-products/add";
const String FETCH_HISTORIES_API =
    "${BASE_URL}api/v1/history/all";
const String FETCH_HISTORY_BY_ID =
    "${BASE_URL}api/v1/history/detail/";
const String DELETE_PRODUCTS_API =
    "${BASE_URL}v1/out-products/sell";
const String GET_UNCONFIRMED_PRODUCTS_API =
    "${BASE_URL}product-api/v1/approve/get/unconfirmed/products";
const String REFRESH_TOKEN_API = "${BASE_URL}api/v1/auth/refresh-token";
const String LOGIN_API = "${BASE_URL}api/v1/auth/log-in";
const String SEARCH_CATEGORIES_API = "${BASE_URL}v1/categories/search/";
const String SEARCH_ADDRESS_API = "${BASE_URL}v1/trade/search/";
const String ALL_PLACES_API = "${BASE_URL}v1/trade/get-all/places/by-status";
