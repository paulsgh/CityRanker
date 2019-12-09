:- use_module(library(http/json)).
:- use_module(library(http/http_open)).
:- use_module(library(lists)).

%% 
% the different category constants on which a user can query
%% 
category("housing", 0).
category("cost", 1).
category("startups", 2).
category("travel", 4).
category("commute", 5).
category("business", 6).
category("safety", 7).
category("healthcare", 8).
category("education", 9).
category("environment", 10).
category("economy", 11).
category("tolerance", 12).
category("taxation", 13).
category("internet", 14).
category("culture", 15).
category("tolerance", 16).
category("outdoors",17).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *** MAIN PROGRAM *** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% 
% entry point to start the program - "main menu"
% write 'main.' to start the program
%% 
main() :-
    nl,
    write("Welcome to CityRanker 2019™!"),
    nl,
    write("Enter 'intro' if you've never used CityRanker 2019™ before."),
    nl,
    write("Enter 'list' if you'd like to see which cities are available to query."),
    nl,
    write("Enter 'skip' if you'd like to access the main program."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: wrap with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Ans),
    main_input(Ans).

% when given 'input', gives user an introduction to the program
% when given 'list', lists the cities when prompted in the main menu
% when given 'skip', directs the user to the main querying options
% when given erroneous input, directs the user back to the main menu
main_input("intro") :-
    nl,
    write("CityRanker 2019™ is your tool for comparing different cities around the world the based on certain quality of life indices."),
    nl,
    write("The scores are out of 10 (10 being the highest) and were gathered from sources such as: World Bank, World Health Organization, United Nations, and more."),
    nl,
    nl,
    write("The following categories can be compared among cities:"),
    nl,
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories),
    nl,
    write("Would you like to view the list of cities that are available to query? ['yes'/'no']."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: wrap with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Ans),
    list_cities_input(Ans).
main_input("list") :-
    list_cities(),
    nl,
    main_options().
main_input("skip") :-
    main_options().
main_input(_) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to main - please try again. ✖✖✖"),
    nl,
    nl,
    main().

%% 
% refered to as 'main querying options'
%% 
main_options() :-
    nl,    
    write("Enter 1 to learn about a particular city."),
    nl,
    write("Enter 2 to compare two different cities."),
    nl,
    read(Answer),
    nl,
    main_options_input(Answer).

% when given the input '1', allows the user to retrieve the score of one city only
% when given the input '2', allows the user to compare two cities' scores
% when given errnoeous input, redirects user to main_options
main_options_input(1):-
    write("Enter the name of the city you would like to learn about."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: lower case, no periods, no commas, spaces replaced with hyphens, wrapped with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Location),
    validate_location(Location),
    nl,
    write("Would you like to view the available categories again? ['yes'/'no']."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: wrap with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Ans),
    print_cat(Ans),
    nl,
    string_concat("Enter the quality you would like to know about in ", Location, String2),
    string_concat(String2, ".", String3),
    write(String3),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: lower case, wrapped with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Category),
    validate_category(Category, Location).
main_options_input(2):-
    write("Enter the name of the first city to compare."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: lower case, no periods, no commas, spaces replaced with hyphens, wrapped with double-quotes ◀◀◀"),
    nl,
    nl,
    read(City1),
    validate_location_two(City1),
    nl,
    write("Enter the name of the second city to compare."),
    nl,
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: lower case, no periods, no commas, spaces replaced with hyphens, wrapped with double-quotes ◀◀◀"),
    nl,
    nl,
    read(City2),
    validate_location_two(City2),
    nl,
    write("Would you like to view the available categories again? ['yes'/'no']."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: wrap with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Ans),
    print_cat_two(Ans),
    nl,
    write("Enter the category which you would like to compare among the cities chosen."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: lower case, wrapped with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Category),
    validate_category_two(Category, City1, City2).
main_options_input(_):-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to options - please try again. ✖✖✖"),
    nl,
    nl,
    main_options().

%% 
% prints the scores of two cities in one category and declares which is higher
% if the score is the same, it declares them to be the same
%% 
compare_two_cities(C1, S1, C2, S2):-
    S1 > S2,
    string_concat(C1, " has a higher score of ", Str2),
    string_concat(Str2, S1, Str1Res),
    string_concat(Str1Res, " as compared to ", Compare),
    string_concat(Compare, S2, S2Res),
    string_concat(S2Res, " in ", Almost),
    string_concat(Almost, C2, FinalRes),
    nl,
    write("⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇"),
    nl,
    nl,
    write(FinalRes),
    nl,
    visualize_two_cities(C1, S1, C2, S2),
    nl,
    nl,
    write("⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆"),
    nl,
    continue().
compare_two_cities(C1, S1, C2, S2):-
    S1 < S2,
    string_concat(C2, " has a higher score of ", Str2),
    string_concat(Str2, S2, Str2Res),
    string_concat(Str2Res, " as compared to ", Compare),
    string_concat(Compare, S1, S1Res),
    string_concat(S1Res, " in ", Almost),
    string_concat(Almost, C1, FinalRes),
    nl,
    write("⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇"),
    nl,
    nl,
    write(FinalRes),
    nl,
    visualize_two_cities(C1, S1, C2, S2),
    nl,
    nl,
    write("⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆"),
    nl,
    continue().
compare_two_cities(C1, S1, C2, S2):-
    S1=S2,
    string_concat("Both cities have the same score of ", S1, Str),
    nl,
    write("⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇"),
    nl,
    nl,
    write(Str),
    nl,
    visualize_two_cities(C1, S2, C2,S2),
    nl,
    nl,
    write("⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆"),
    nl,
    continue().

% asks the user whether they'd like to continue the program by entering another query
continue() :-
    nl,
    nl,
    write("Would you like to try another query with CityRanker 2019™? ['yes'/'no']."),
    nl,
    write("Or, would you like to go back to the main menu? ['main']."),
    nl,
    nl,
    write("▶▶▶ INPUT FORMAT: wrap with double-quotes ◀◀◀"),
    nl,
    nl,
    read(Ans),
    continue_input(Ans).

% directs the user to main_options, the main menu, or ends the program
% if given erroneous input, redirects to continuation options once again
continue_input("Yes") :-
    nl,
    nl,
    main_options().
continue_input("yes") :-
    nl,
    nl,
    main_options().
continue_input("y") :-
    nl,
    nl,
    main_options().
continue_input("main") :-
    nl,
    nl,
    main().
continue_input("no") :-
    write("Thank you for using CityRanker 2019™. Goodbye.").
continue_input("No") :-
    write("Thank you for using CityRanker 2019™. Goodbye.").
continue_input("n") :-
    write("Thank you for using CityRanker 2019™. Goodbye.").
continue_input("N") :-
    write("Thank you for using CityRanker 2019™. Goodbye.").
continue_input(_) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to continuation options - please try again. ✖✖✖"),
    nl,
    nl,
    continue().


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *** ALL HELPERS *** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *** API HELPERS *** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% true if Score is the rating for City based on Feature, and V is the visualization of Score
city_score(City,Feature,Score, V) :-
    open_url_query(Data, City),
    Categories = Data.get('categories'),
    string_concat("", Feature, F1),
    category(F1, X),
    nth0(X, Categories, FirstView),
    Score = FirstView.get('score_out_of_10'),
    visualize_score(City, Score, V).

% querying results from the API at https://developers.teleport.org/api/reference/#!/urban_areas/getUrbanAreaScores
open_url_query(Data, Location) :-
    Url_Start = "https://api.teleport.org/api/urban_areas/slug%3A",
    Url_End = "/scores/",
    string_concat(Url_Start, Location, Url_Mid),
    string_concat(Url_Mid, Url_End, URL),
    setup_call_cleanup(
        http_open(URL, In, [request_header('Accept'='application/json')]),
        json_read_dict(In, Data),
        close(In)
    ).

% calls helpers to print the list of all valid cities from an API
list_cities() :-
    get_city_list_obj(ListObj),
    get_names_cities(ListObj,1),
    nl,
    nl,
    write("▶▶▶ NOTE: When querying city names that contain commas, periods, or spaces, the user must omit all punctuation and replace spaces with hyphens ◀◀◀"),
    nl,
    write("▶▶▶ NOTE: For example, to query 'Washington, D.C.', the user must enter 'washington-dc' [wrapped in double-quotes]                             ◀◀◀"),
    nl.

% gets list object of all valid cities that are available to query.
get_city_list_obj(ListObj) :-
    open_url_list(Response),
    Links = Response.get('_links'),
    ListObj = Links.get('ua:item').

% Reference: https://stackoverflow.com/questions/29167342/prolog-http-get-request-with-request-headers
open_url_list(Response):-
    setup_call_cleanup(
        http_open('https://api.teleport.org/api/urban_areas', In, [request_header('Accept'='application/json')]),
        json_read_dict(In, Response),
        close(In)
    ).

% organizes the cities to be outputted in three columns when printed
% gets result from API at https://developers.teleport.org/api/reference/#!/urban_areas/listUrbanAreas
get_names_cities([], _).
get_names_cities([H|T], N) :-
    nth0(0, [H|T], FirstName),
    Name = FirstName.get('name'),
    (mod(N,3) =:= 0 ->
    write(Name),
    nl,
    N1 is N+1,
    get_names_cities(T, N1);
    write(Name),
    string_length(Name, NameLen),
    tab(30 - NameLen),
    N1 is N+1,
    get_names_cities(T, N1)).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *** CITIES HELPERS *** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% lists the cities available to query if the user gives yes/Yes/y/Y
% if given no/No/n/N, the user is redirected to the main querying options
% if given any other input, the user is redirected to the introduction
list_cities_input("yes") :-
    nl,
    list_cities,
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input("Yes") :-
    nl,
    list_cities,
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input("y") :-
    nl,
    list_cities,
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input("Y") :-
    nl,
    list_cities,
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input("no") :-
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input("No") :-
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input("n") :-
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input("N") :-
    nl,
    nl,
    write("Now let's try it out!"),
    nl,
    main_options().
list_cities_input(_) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to intro - please try again. ✖✖✖"),
    nl,
    main_input("intro").

%% check that input city is a valid city (when querying 1 city).
%% if so, continue program. otherwise, return to 1 city query options.
validate_location(Location) :-
    Cities = ["aarhus", "adelaide", "albuquerque", "almaty", "amsterdam", "anchorage", "andorra", "ankara", "asheville", "asuncion", "athens", "atlanta", "auckland", "austin", "baku", "bali", "baltimore", "bangkok", "barcelona", "beijing", "beirut", "belfast", "belgrade", "belize-city", "bengaluru", "bergen", "berlin", "bern", "bilbao", "birmingham", "birmingham-al", "bogota", "boise", "bologna", "bordeaux", "boston", "boulder", "bozeman", "bratislava", "brighton", "brisbane", "bristol", "brno", "brussels", "bucharest", "budapest", "buenos-aires", "buffalo", "cairo", "calgary", "cambridge", "cape-town", "caracas", "cardiff", "casablanca", "charleston", "charlotte", "chattanooga", "chennai", "chiang-mai", "chicago", "chisinau", "christchurch", "cincinnati", "cleveland", "cluj-napoca", "cologne", "colorado-springs", "columbus", "copenhagen", "cork", "curitiba", "dallas", "dar-es-salaam", "delhi", "denver", "des-moines", "detroit", "doha", "dresden", "dubai", "dublin", "dusseldorf", "edinburgh", "edmonton", "eindhoven", "eugene", "florence", "florianopolis", "fort-collins", "frankfurt", "fukuoka", "galway", "gdansk", "geneva", "gibraltar", "glasgow", "gothenburg", "grenoble", "guadalajara", "guatemala-city", "halifax", "hamburg", "hannover", "havana", "helsinki", "ho-chi-minh-city", "hong-kong", "honolulu", "houston", "hyderabad", "indianapolis", "innsbruck", "istanbul", "jacksonville", "jakarta", "johannesburg", "kansas-city", "karlsruhe", "kathmandu", "kiev", "kingston", "knoxville", "krakow", "kuala-lumpur", "kyoto", "lagos", "la-paz", "las-palmas-de-gran-canaria", "las-vegas", "lausanne", "leeds", "leipzig", "lille", "lima", "lisbon", "liverpool", "ljubljana", "london", "los-angeles", "louisville", "luxembourg", "lviv", "lyon", "madison", "madrid", "malaga", "malmo", "managua", "manchester", "manila", "marseille", "medellin", "melbourne", "memphis", "mexico-city", "miami", "milan", "milwaukee", "minneapolis-saint-paul", "minsk", "montevideo", "montreal", "moscow", "mumbai", "munich", "nairobi", "nantes", "naples", "nashville", "new-orleans", "new-york", "nice", "nicosia", "oklahoma-city", "omaha", "orlando", "osaka", "oslo", "ottawa", "oulu", "oxford", "palo-alto", "panama", "paris", "perth", "philadelphia", "phnom-penh", "phoenix", "phuket", "pittsburgh", "portland-me", "portland-or", "porto", "porto-alegre", "prague", "providence", "quebec", "quito", "raleigh", "reykjavik", "richmond", "riga", "rio-de-janeiro", "riyadh", "rochester", "rome", "rotterdam", "saint-petersburg", "salt-lake-city", "san-antonio", "san-diego", "san-francisco-bay-area", "san-jose", "san-juan", "san-luis-obispo", "san-salvador", "santiago", "santo-domingo", "sao-paulo", "sarajevo", "saskatoon", "seattle", "seoul", "seville", "shanghai", "singapore", "skopje", "sofia", "st-louis", "stockholm", "stuttgart", "sydney", "taipei", "tallinn", "tampa-bay-area", "tampere", "tartu", "tashkent", "tbilisi", "tehran", "tel-aviv", "the-hague", "thessaloniki", "tokyo", "toronto", "toulouse", "tunis", "turin", "turku", "uppsala", "utrecht", "valencia", "valletta", "vancouver", "victoria", "vienna", "vilnius", "warsaw", "washington-dc", "wellington", "winnipeg", "wroclaw", "yerevan", "zagreb", "zurich"],
    member(Location, Cities).
validate_location(Location) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to 1 city query options - please try again. ✖✖✖"),
    nl,
    nl,
    main_options_input(1).

%% check that input city is a valid city (when querying 2 cities).
%% if so, continue program. otherwise, return to 2 city query options.
validate_location_two(Location) :-
    Cities = ["aarhus", "adelaide", "albuquerque", "almaty", "amsterdam", "anchorage", "andorra", "ankara", "asheville", "asuncion", "athens", "atlanta", "auckland", "austin", "baku", "bali", "baltimore", "bangkok", "barcelona", "beijing", "beirut", "belfast", "belgrade", "belize-city", "bengaluru", "bergen", "berlin", "bern", "bilbao", "birmingham", "birmingham-al", "bogota", "boise", "bologna", "bordeaux", "boston", "boulder", "bozeman", "bratislava", "brighton", "brisbane", "bristol", "brno", "brussels", "bucharest", "budapest", "buenos-aires", "buffalo", "cairo", "calgary", "cambridge", "cape-town", "caracas", "cardiff", "casablanca", "charleston", "charlotte", "chattanooga", "chennai", "chiang-mai", "chicago", "chisinau", "christchurch", "cincinnati", "cleveland", "cluj-napoca", "cologne", "colorado-springs", "columbus", "copenhagen", "cork", "curitiba", "dallas", "dar-es-salaam", "delhi", "denver", "des-moines", "detroit", "doha", "dresden", "dubai", "dublin", "dusseldorf", "edinburgh", "edmonton", "eindhoven", "eugene", "florence", "florianopolis", "fort-collins", "frankfurt", "fukuoka", "galway", "gdansk", "geneva", "gibraltar", "glasgow", "gothenburg", "grenoble", "guadalajara", "guatemala-city", "halifax", "hamburg", "hannover", "havana", "helsinki", "ho-chi-minh-city", "hong-kong", "honolulu", "houston", "hyderabad", "indianapolis", "innsbruck", "istanbul", "jacksonville", "jakarta", "johannesburg", "kansas-city", "karlsruhe", "kathmandu", "kiev", "kingston", "knoxville", "krakow", "kuala-lumpur", "kyoto", "lagos", "la-paz", "las-palmas-de-gran-canaria", "las-vegas", "lausanne", "leeds", "leipzig", "lille", "lima", "lisbon", "liverpool", "ljubljana", "london", "los-angeles", "louisville", "luxembourg", "lviv", "lyon", "madison", "madrid", "malaga", "malmo", "managua", "manchester", "manila", "marseille", "medellin", "melbourne", "memphis", "mexico-city", "miami", "milan", "milwaukee", "minneapolis-saint-paul", "minsk", "montevideo", "montreal", "moscow", "mumbai", "munich", "nairobi", "nantes", "naples", "nashville", "new-orleans", "new-york", "nice", "nicosia", "oklahoma-city", "omaha", "orlando", "osaka", "oslo", "ottawa", "oulu", "oxford", "palo-alto", "panama", "paris", "perth", "philadelphia", "phnom-penh", "phoenix", "phuket", "pittsburgh", "portland-me", "portland-or", "porto", "porto-alegre", "prague", "providence", "quebec", "quito", "raleigh", "reykjavik", "richmond", "riga", "rio-de-janeiro", "riyadh", "rochester", "rome", "rotterdam", "saint-petersburg", "salt-lake-city", "san-antonio", "san-diego", "san-francisco-bay-area", "san-jose", "san-juan", "san-luis-obispo", "san-salvador", "santiago", "santo-domingo", "sao-paulo", "sarajevo", "saskatoon", "seattle", "seoul", "seville", "shanghai", "singapore", "skopje", "sofia", "st-louis", "stockholm", "stuttgart", "sydney", "taipei", "tallinn", "tampa-bay-area", "tampere", "tartu", "tashkent", "tbilisi", "tehran", "tel-aviv", "the-hague", "thessaloniki", "tokyo", "toronto", "toulouse", "tunis", "turin", "turku", "uppsala", "utrecht", "valencia", "valletta", "vancouver", "victoria", "vienna", "vilnius", "warsaw", "washington-dc", "wellington", "winnipeg", "wroclaw", "yerevan", "zagreb", "zurich"],
    member(Location, Cities).
validate_location_two(Location) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to 2 city query options - please try again. ✖✖✖"),
    nl,
    nl,
    main_options_input(2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *** CATEGORIES HELPERS *** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% lists the available categories to query
print_categories([]).
print_categories([Cat|T]) :-
    write(Cat),
    nl,
    print_categories(T).

%% prints the categories if the user inputs Yes/yes/y/Y (when querying 1 city)
%% continues program if the user inputs No/no/n/No
%% otherwise, returns to 1 city query options
print_cat("Yes") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat("yes") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat("y") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat("Y") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat("no").
print_cat("No").
print_cat("n").
print_cat("N").
print_cat(_) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to 1 city query options - please try again. ✖✖✖"),
    nl,
    nl,
    main_options_input(1).

%% prints the categories if the user inputs Yes/yes/y/Y (when querying 2 cities)
%% continues program if the user inputs No/no/n/No
%% otherwise, returns to 2 city query options
print_cat_two("Yes") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat_two("yes") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat_two("y") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat_two("Y") :-
    nl,
    Categories = [housing,cost,startups,travel,commute,business,safety,healthcare,education,environment,economy,tolerance,taxation,internet,culture,outdoors],
    print_categories(Categories).
print_cat_two("no").
print_cat_two("No").
print_cat_two("n").
print_cat_two("N").
print_cat_two(_) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to 2 city query options - please try again. ✖✖✖"),
    nl,
    nl,
    main_options_input(2).

%% checks that input category is a valid category (when querying 1 city)
%% if so, continue program. otherwise, return to 1 city query options
validate_category(Category, Location) :-
    Categories = ["housing", "cost", "startups", "travel", "commute", "business", "safety", "healthcare", "education",
                  "environment", "economy", "tolerance", "taxation", "internet", "culture", "outdoors"],
    member(Category, Categories),
    nl,
    city_score(Location, Category, Score, V),
    string_concat(Location, " has a score of ", Res1),
    string_concat(Res1, Score, Res2),
    string_concat(Res2, " in the category: ", Res3),
    string_concat(Res3, Category, Res4),
    string_concat(Res4, ".", Result),
    write("⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇ ⬇"),
    nl,
    nl,
    write(Result),
    nl,
    string_concat(Location, "=", P1),
    write(P1),
    write(V),
    nl,
    nl,
    write("⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆ ⬆"),
    nl,
    continue().
validate_category(Category, _) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to 1 city query options - please try again. ✖✖✖"),
    nl,
    nl,
    main_options_input(1).

%% checks that input category is a valid category (when comparing 2 cities)
%% if so, continue program. otherwise, return to 2 city query options
validate_category_two(Category, City1, City2) :-
    Categories = ["housing", "cost", "startups", "travel", "commute", "business", "safety", "healthcare", "education",
                  "environment", "economy", "tolerance", "taxation", "internet", "culture", "outdoors"],
    member(Category, Categories),
    city_score(City1, Category, S1, V1),
    city_score(City2, Category, S2, V2),
    compare_two_cities(City1, S1, City2, S2).
validate_category_two(Category, _, _) :-
    nl,
    write("✖✖✖ ERROR: bad input. Redirecting to 2 city query options - please try again. ✖✖✖"),
    nl,
    nl,
    main_options_input(2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% *** VISUALIZATION HELPERS *** %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% true if Str appended to list List N times is L1
attach_point(0, List, Str, List).
attach_point(N, [], E, L2):-
    N1 is N-1,
    append([], E, L1),
    attach_point(N1, [], E, T2),
    append(L1, T2, L2).

% true if L2 is the visualized score list of Score for City
visualize_score(City, Score, L2):-
    S is round(Score),
    attach_point(S, [],["★"], L2).


% true when D is the difference between numbers L1 and L2.
dif(L1, L2, 0):-
    L1==L2.
dif(L1, L2, D):-
    L1>L2,
    D is L1-L2.
dif(L1, L2, D):-
    L2>L1,
    D is L2-L1.

% true when Str2 is Str with N spaces appended to the end of Str.
add_space(0, Str, Str).
add_space(N, Str, Str2):-
    string_concat("", " ", S),
    N1 is N-1,
    add_space(N1, S, Str3),
    string_concat(Str, Str3, Str2).

% makes a visualization of city C1 with score S1 and city C2 with score S2.
visualize_two_cities(C1, S1, C2, S2):-
    string_codes(C1, List1),
    string_codes(C2, List2),
    length(List1, L1),
    length(List2, L2),
    L1>=L2,
    dif(L1, L2, D),
    add_space(D, C2, SS),
    visualize_score(C1, S1, V1),
    visualize_score(C2,S2,V2),
    string_concat(C1, "=", P1),
    write(P1),
    write(V1),
    nl,
    string_concat(SS, "=", P2),
    write(P2),
    write(V2).

visualize_two_cities(C1, S1, C2, S2):-
    string_codes(C1, List1),
    string_codes(C2, List2),
    length(List1, L1),
    length(List2, L2),
    L2>L1,
    dif(L1, L2, D),
    add_space(D, C1, SS),
    visualize_score(C1, S1, V1),
    visualize_score(C2,S2,V2),
    string_concat(C2, "=", P2),
    write(P2),
    write(V2),
    nl,
    string_concat(SS, "=", P1),
    write(P1),
    write(V1).
