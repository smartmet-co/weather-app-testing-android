import os

# Geolocation coordinates
DICT__GEO_LOCATION_COORDINATES_DICT = {'Kokkola':'23.126016871154913 63.84141087895833',
                                       'Seattle':'-122.34645486382637 47.58411206957979',
                                       'Savukoski':'28.158609 67.272971',
                                       'Canberra':'149.191053541925 -35.30409478641632',
                                       'Kangaarsuk': '-55.59866964422559 72.00018508900453',
                                       'Kingston': '-76.42371887243596 17.999747478501888',
                                       'Tolhuin':'-67.0462633384681 -54.504036999322736',
                                       'Johannesburg':'27.038196165228324 -26.190758716030867',
                                       'Lissabon':'-9.471483203214412 38.75762489355381',
                                       'Oulu':'25.81 65.05',
                                       'Posio':'28.167490306012272 66.11112685817982'}

# Dut default locations
LOCAL_DEFAULT_LOCATION = 'Bogotá'
LOCAL_DEFAULT_LOCATION_LONG = 'Bogotá, Colombia'
CI_DEFAULT_LOCATION = 'Crittenden School Park'
CI_PLATFORM_VERSION = os.getenv('PLATFORM_VERSION', '')
if CI_PLATFORM_VERSION == '15':
    CI_DEFAULT_LOCATION = LOCAL_DEFAULT_LOCATION

# Icon names
ICON_NAME_1 = '//com.horcrux.svg.PathView'