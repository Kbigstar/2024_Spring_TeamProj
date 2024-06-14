// 카카오맵
var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(36.350411, 127.384548), // 맵의 중심 좌표
    level: 9, // 초기 확대 레벨
    zoomable: false, // 확대/축소 비활성화
    scrollwheel: false // 마우스 스크롤에 따른 확대/축소 비활성화
};

var map = new kakao.maps.Map(mapContainer, mapOption); // 맵 인스턴스 생성


// 대전시의 각 구에 대한 다각형을 그립니다.
var geoJsonData = [
	// 구들의 다각형 좌표를 여기에 추가합니다.
    { "type": "Feature", "geometry": { "type": "Polygon", "coordinates": [[[127.48423140565102, 36.47579777364857], [127.4842758315723, 36.47562412331248], [127.49608772508965, 36.454788541498615], [127.49646617922754, 36.45490693371369], [127.50359592138227, 36.45404556747004], [127.50378856631073, 36.45370091471977], [127.49242965825947, 36.43937313216669], [127.45535273501828, 36.40026888052006], [127.43244384025994, 36.359109781392185], [127.43076653933842, 36.35682449708662], [127.4274755984888, 36.35546388785732], [127.42754559251308, 36.35502141793945], [127.41499183717423, 36.340927031789455], [127.40390013970242, 36.34963132440502], [127.39327191067527, 36.370856451726986], [127.39291081350945, 36.37141438413276], [127.3926528560624, 36.37212630227893], [127.39423574888389, 36.37334106585436], [127.39555347992915, 36.37351470217326], [127.39643809381873, 36.37367202181869], [127.40290731673932, 36.3760819144518], [127.40352001349592, 36.37624291504401], [127.40937537863408, 36.3782594089287], [127.40981898322612, 36.378612726400014], [127.41972394472053, 36.41530525648254], [127.40082597902533, 36.45489489777627], [127.40208033062072, 36.45603035972385], [127.40208793081314, 36.456034766481885], [127.40583088623073, 36.45493887301716], [127.40629368191229, 36.45491308151158], [127.43213088902965, 36.45662158878229], [127.43378961320785, 36.45653731006544], [127.46155929102703, 36.455093606878705], [127.46179254630326, 36.45533714458919], [127.47987111516115, 36.47706397762062], [127.48061072944839, 36.47720998801473], [127.48423140565102, 36.47579777364857]]] }, "properties": { "SIG_CD": "30230", "SIG_ENG_NM": "Daedeok-gu", "SIG_KOR_NM": "대덕구" } },
    { "type": "Feature", "geometry": { "type": "Polygon", "coordinates": [[[127.33590314807691, 36.32904444274447], [127.33590160267202, 36.32875586659478], [127.31003418758425, 36.27297054398968], [127.29226170530319, 36.26432058142261], [127.29193521755285, 36.2642418810221], [127.29175087417394, 36.264688171465096], [127.29152653712686, 36.264963801690946], [127.29112601164293, 36.26541255315003], [127.29097842826602, 36.26550898527344], [127.29073867213106, 36.26566636256972], [127.29062252539923, 36.265720201080676], [127.29046056168447, 36.26579513778587], [127.28776338732885, 36.265486749984646], [127.28746961229015, 36.265367397348584], [127.28707731920593, 36.26517157860222], [127.28650629357351, 36.26494975423987], [127.2858626063573, 36.264814639450044], [127.28540877536018, 36.2647891326042], [127.28404957708341, 36.264768586524866], [127.28345785825233, 36.26478963796036], [127.2825607323952, 36.26486498881787], [127.28209237353798, 36.26492807201049], [127.280954950416, 36.26536447455258], [127.2796447202494, 36.26589048591378], [127.27944440345912, 36.26608337326654], [127.27925998459611, 36.26638467997926], [127.2786454782232, 36.26706871619389], [127.27811568162112, 36.26740544441805], [127.27678188042816, 36.267715131776576], [127.27560641361588, 36.26812831136427], [127.27401052970355, 36.26899776145539], [127.27334437295143, 36.26937600914062], [127.27249092047413, 36.26978293794841], [127.27175452556688, 36.270135479805326], [127.2710415411951, 36.270507646466314], [127.27052291576263, 36.27080806157827], [127.27039821005461, 36.27088432042975], [127.26980514409647, 36.27113128831847], [127.26935720800647, 36.27139742054917], [127.26897587737908, 36.27168020949977], [127.26874277306588, 36.27188482156756], [127.26773517734617, 36.27256139727233], [127.26741021672349, 36.27282434642885], [127.2668122455133, 36.27340176538583], [127.26616799192229, 36.27382479268562], [127.2657852281229, 36.27408545089652], [127.26535231747701, 36.274360988038964], [127.26452118406013, 36.27468803751742], [127.26420938629498, 36.27479025946364], [127.26267158550456, 36.27528279859929], [127.26234705733641, 36.27538005970765], [127.2600302454533, 36.275772617415676], [127.25831737179614, 36.27637379311039], [127.25816552801072, 36.27647584471373], [127.25751043500945, 36.27699605973853], [127.25715985383457, 36.277364428959096], [127.25592758871748, 36.278642781232605], [127.2555386429852, 36.27909842602789], [127.25481753273935, 36.28003971801137], [127.25453593914352, 36.28024420674014], [127.25415340653909, 36.28105751178662], [127.25402511358207, 36.281339681869916], [127.25382311234661, 36.282023105856545], [127.25381993346467, 36.28203820733288], [127.25363787906984, 36.28236283647005], [127.25239439861348, 36.2832812062695], [127.25205181487443, 36.28350047953781], [127.25098326762998, 36.28477306454421], [127.25097127751219, 36.284807397218295], [127.2508047923826, 36.28527337667307], [127.25072094327795, 36.28550132450261], [127.25055632906971, 36.28572281817963], [127.2498434102258, 36.28641044210677], [127.24949244799726, 36.28661941628374], [127.24940455298628, 36.28666782958813], [127.248858029195, 36.287013267223145], [127.24876159713716, 36.28711856180057], [127.24854441293853, 36.28751019596207], [127.24845272353238, 36.287987110728665], [127.24823476925668, 36.288994557978285], [127.24665270656907, 36.290959512575235], [127.24691951401135, 36.29109420587199], [127.25950839864588, 36.30309303998275], [127.25801200206942, 36.30993348294424], [127.25804884968265, 36.310073690481026], [127.27806793747585, 36.34591693427957], [127.28751874825147, 36.41549922948789], [127.29124795916188, 36.418684989807275], [127.34068600537469, 36.43448192229321], [127.36366303474692, 36.4741082820269], [127.36375322094028, 36.474172005196195], [127.36398643217484, 36.474816684677144], [127.36398733719608, 36.47492680043736], [127.36282580842493, 36.475942416574554], [127.36272126148576, 36.47591485113452], [127.36257490971155, 36.47597948902337], [127.36246426395847, 36.476001037128505], [127.36241441909324, 36.476068407899625], [127.36237286153447, 36.47609134720782], [127.36231246222556, 36.47615179281275], [127.36230186870603, 36.476160556711115], [127.36222395837069, 36.476280195178354], [127.36220064033378, 36.47634074799455], [127.36221325638242, 36.47645313930603], [127.36218241451412, 36.47660228065346], [127.36202975572957, 36.47673697807245], [127.36198629313785, 36.47668838338687], [127.36184179216023, 36.47665729152507], [127.36195435759774, 36.47671749925561], [127.36195827598237, 36.476775293669284], [127.36194817663244, 36.47681158047205], [127.36191160615599, 36.47682266691526], [127.36189325442042, 36.47688863186016], [127.36176187096967, 36.47698607074789], [127.36171977089803, 36.47700303214337], [127.36164599048631, 36.476957235289994], [127.36158143105035, 36.477023043261994], [127.36156191956832, 36.47710803237071], [127.36150379738959, 36.477198163513386], [127.36146913241224, 36.477317103019935], [127.36141027233731, 36.47737050191442], [127.3613811129723, 36.477504804262324], [127.36135997015579, 36.47754395117445], [127.36131972739341, 36.47763458371882], [127.36125050607815, 36.477683932476005], [127.36122625871766, 36.47780980867956], [127.36115145965852, 36.47786190134488], [127.36116178047003, 36.47792968487599], [127.36000324097742, 36.481697099575456], [127.35990212636116, 36.481759990111684], [127.35962552742524, 36.48182304532079], [127.35913728288756, 36.4820991234039], [127.3591321821299, 36.48214555973596], [127.35908444846241, 36.48216335277346], [127.35902431002742, 36.482165128202396], [127.35906335738305, 36.482233904462646], [127.35907744764455, 36.48231775941043], [127.35906910447827, 36.482384561586], [127.35901615990569, 36.482450889515995], [127.35895554647587, 36.482522327061304], [127.35891265996801, 36.48249981640673], [127.35886765072588, 36.48255496866077], [127.35885685963069, 36.482564859800874], [127.365065621659, 36.489110414092394], [127.36860776943544, 36.488420857617804], [127.36869717305991, 36.48844689638518], [127.36893523825057, 36.48853914338508], [127.36900699112203, 36.488578195494235], [127.36890522639355, 36.489590337849904], [127.37081951354037, 36.49015759181576], [127.3714327424531, 36.49054128406744], [127.37195113524072, 36.49088053562312], [127.37270107204144, 36.49137975881839], [127.37421409323323, 36.49253739325824], [127.3775911369554, 36.49561926282489], [127.37898494115039, 36.4976526874277], [127.37940291784645, 36.49826995841778], [127.37973546641796, 36.49872744148586], [127.38033654837668, 36.49953929874922], [127.38096688868224, 36.499660645040414], [127.38230954158374, 36.49992457252601], [127.38385497104343, 36.500230690026456], [127.3853837290118, 36.49944480859745], [127.39143430090824, 36.4952949020811], [127.3915044838695, 36.495239768065105], [127.39198124737584, 36.49489697808944], [127.39266181613132, 36.494230739016544], [127.39296333286408, 36.49393926599678], [127.39334911882293, 36.493563223735], [127.39501480788981, 36.492452143509276], [127.39558518098194, 36.49207521901996], [127.39575988535204, 36.49195602619904], [127.39614272100404, 36.49170658248413], [127.39620866363376, 36.49166381248541], [127.39647588035456, 36.49140226679927], [127.39671310417164, 36.49117337410481], [127.39689693189491, 36.49099677582732], [127.39696884351403, 36.490929806800786], [127.39771542615455, 36.490210711610054], [127.39811343430462, 36.489838630062756], [127.39892239444629, 36.48910476571362], [127.40016262011663, 36.48798398137457], [127.40110689881237, 36.48714976223556], [127.40150545668112, 36.486799511658276], [127.40237124843696, 36.48604935237266], [127.40301410590469, 36.485483621796156], [127.40320967485741, 36.48472199442748], [127.40376925346968, 36.48256945670892], [127.40414412553953, 36.481114258138156], [127.40416324517709, 36.47982948461316], [127.40416240148282, 36.47750959821061], [127.40416031663409, 36.47656769319356], [127.40331481718957, 36.474863914947406], [127.40208793081314, 36.456034766481885], [127.40208033062072, 36.45603035972385], [127.40082597902533, 36.45489489777627], [127.41972394472053, 36.41530525648254], [127.40981898322612, 36.378612726400014], [127.40937537863408, 36.3782594089287], [127.40352001349592, 36.37624291504401], [127.40290731673932, 36.3760819144518], [127.39643809381873, 36.37367202181869], [127.39555347992915, 36.37351470217326], [127.39423574888389, 36.37334106585436], [127.3926528560624, 36.37212630227893], [127.39291081350945, 36.37141438413276], [127.39291674253649, 36.371405226887276], [127.39291444150558, 36.37140611911583], [127.39267853701291, 36.37149760832374], [127.3877966492265, 36.37128945214708], [127.38752666877164, 36.37131855784529], [127.37710113705384, 36.371961202095605], [127.37638389499368, 36.37187753855188], [127.36560426970179, 36.364129439969176], [127.36519437708915, 36.36398276173377], [127.35850356472568, 36.35870193027713], [127.35825943257312, 36.3579964586429], [127.33590314807691, 36.32904444274447]]] }, "properties": { "SIG_CD": "30200", "SIG_ENG_NM": "Yuseong-gu", "SIG_KOR_NM": "유성구" } },
    { "type": "Feature", "geometry": { "type": "Polygon", "coordinates": [[[127.37246015994826, 36.27217852017392], [127.36419690096908, 36.218901293107535], [127.33169756735153, 36.184055584700545], [127.31564078187029, 36.2208153706037], [127.28138837924314, 36.245570998733726], [127.29191568510345, 36.264235368291374], [127.29193521755285, 36.2642418810221], [127.29226170530319, 36.26432058142261], [127.31003418758425, 36.27297054398968], [127.33590160267202, 36.32875586659478], [127.33590314807691, 36.32904444274447], [127.35825943257312, 36.3579964586429], [127.35850356472568, 36.35870193027713], [127.36519437708915, 36.36398276173377], [127.36560426970179, 36.364129439969176], [127.37638389499368, 36.37187753855188], [127.37710113705384, 36.371961202095605], [127.38752666877164, 36.37131855784529], [127.3877966492265, 36.37128945214708], [127.39267853701291, 36.37149760832374], [127.39291444150558, 36.37140611911583], [127.39291674253649, 36.371405226887276], [127.39327191067527, 36.370856451726986], [127.40390013970242, 36.34963132440502], [127.37333043360067, 36.29328480351174], [127.37331287908408, 36.293287390158646], [127.37276277951884, 36.29194493854678], [127.3698971752841, 36.290059642904914], [127.37011445524374, 36.28917919790114], [127.37246015994826, 36.27217852017392]]] }, "properties": { "SIG_CD": "30170", "SIG_ENG_NM": "Seo-gu", "SIG_KOR_NM": "서구" } },
    { "type": "Feature", "geometry": { "type": "Polygon", "coordinates": [[[127.42232979879932, 36.20808287730144], [127.37246015994826, 36.27217852017392], [127.37011445524374, 36.28917919790114], [127.3698971752841, 36.290059642904914], [127.37276277951884, 36.29194493854678], [127.37331287908408, 36.293287390158646], [127.37333043360067, 36.29328480351174], [127.40390013970242, 36.34963132440502], [127.41499183717423, 36.340927031789455], [127.45550790557535, 36.30132458346413], [127.42731037062387, 36.288608163656235], [127.44229536631985, 36.238193127537755], [127.42232979879932, 36.20808287730144]]] }, "properties": { "SIG_CD": "30140", "SIG_ENG_NM": "Jung-gu", "SIG_KOR_NM": "중구" } },
    { "type": "Feature", "geometry": { "type": "Polygon", "coordinates": [[[127.49376677840112, 36.42524291126991], [127.49391149267069, 36.42506433684779], [127.51451255356123, 36.422473524131924], [127.53743488707592, 36.42031793555901], [127.53778251345909, 36.420122906450636], [127.54228045721094, 36.41927919316185], [127.54185971218202, 36.415857565503515], [127.54707246862364, 36.40845961094689], [127.54707923357314, 36.40845451555863], [127.55816509542842, 36.399675961089635], [127.55877982480084, 36.39985614586992], [127.5591919070479, 36.39914652779875], [127.5596787132188, 36.3982188851674], [127.5550799668551, 36.39518677865676], [127.55494609391997, 36.395147126420156], [127.52480439828086, 36.38380225175371], [127.50134153132878, 36.34006989563066], [127.49257692314637, 36.2379539466615], [127.44871613365747, 36.196722887604025], [127.42232979879932, 36.20808287730144], [127.44229536631985, 36.238193127537755], [127.42731037062387, 36.288608163656235], [127.45550790557535, 36.30132458346413], [127.41499183717423, 36.340927031789455], [127.42754559251308, 36.35502141793945], [127.4274755984888, 36.35546388785732], [127.43076653933842, 36.35682449708662], [127.43244384025994, 36.359109781392185], [127.45535273501828, 36.40026888052006], [127.49242965825947, 36.43937313216669], [127.49376677840112, 36.42524291126991]]] }, "properties": { "SIG_CD": "30110", "SIG_ENG_NM": "Dong-gu", "SIG_KOR_NM": "동구" } }
];



var geoJsonObj = {
    "type": "FeatureCollection",
    "features": geoJsonData
};

var features = geoJsonObj.features;


// 각 다각형의 중심점을 계산하고 구 이름을 표시하는 함수
function addLabels() {
    for (var i = 0; i < features.length; i++) {
        (function (feature) {  // 클로저를 사용하여 각 Feature를 캡처합니다.
            var geometry = feature.geometry;
            var coordinates = geometry.coordinates;
            var centroid = getPolygonCentroid(coordinates);

            // HTML 콘텐츠를 생성하고 클릭 이벤트 리스너를 추가합니다.
            var content = document.createElement('div');
            content.className = 'label';
            content.textContent = feature.properties.SIG_KOR_NM;
            content.style.cursor = 'pointer'; // 커서 스타일 추가
            // 클릭 이벤트 리스너
            content.onclick = function () {
            	fetchDistrictData(feature.properties.SIG_KOR_NM);
            	fetchForecastData(feature.properties.SIG_KOR_NM); // 예측 데이터 호출
                console.log(feature.properties.SIG_KOR_NM);
            };

            var label = new kakao.maps.CustomOverlay({
                position: centroid,
                content: content, // 생성한 HTML 요소 사용
                zIndex: 2
            });

            label.setMap(map);
        })(features[i]); // 즉시 실행 함수로 각 feature를 전달합니다.
    }
}

// 다각형의 중심점 계산 함수
function getPolygonCentroid(coordinates) {
    var totalArea = 0;
    var centerX = 0;
    var centerY = 0;

    for (var j = 0; j < coordinates.length; j++) {
        var points = coordinates[j];
        var area = 0;
        var x = 0;
        var y = 0;

        for (var k = 0; k < points.length; k++) {
            var nextPoint = points[(k + 1) % points.length];
            var currentPoint = points[k];
            var diff = (nextPoint[0] * currentPoint[1]) - (currentPoint[0] * nextPoint[1]);
            area += diff;
            x += (nextPoint[0] + currentPoint[0]) * diff;
            y += (nextPoint[1] + currentPoint[1]) * diff;
        }

        totalArea += area;
        centerX += x;
        centerY += y;
    }

    totalArea /= 2;

    centerX /= (6 * totalArea);
    centerY /= (6 * totalArea);

    return new kakao.maps.LatLng(centerY, centerX);
}


//다각형 생성 코드
var mapContainer = document.getElementById('map');
var mapOption = {
    center: new kakao.maps.LatLng(36.350411, 127.384548),
    level: 10,
    draggable: false,
    zoomable: false,
    disableDoubleClick: true, // 더블 클릭을 사용한 확대 비활성화
    disableDoubleClickZoom: true // 더블 클릭을 사용한 확대/축소 비활성화
};

var map = new kakao.maps.Map(mapContainer, mapOption);

var features = geoJsonObj.features;

var colors = ['rgb(170, 229, 146)', 'rgb(60, 179, 87)', 'rgb(70, 205, 88)', 'rgb(49, 185, 34)', 'rgb(5, 133, 5)'];
var hoverColor = 'rgb(255, 255, 255)'; // 마우스 오버 시 변경될 색상

//폴리곤 생성 및 이벤트 추가 부분
for (var i = 0; i < features.length; i++) {
    (function (feature) {
        var geometry = feature.geometry;
        var coordinates = geometry.coordinates;
        var paths = [];

        for (var j = 0; j < coordinates.length; j++) {
            var points = coordinates[j];
            var path = [];

            for (var k = 0; k < points.length; k++) {
                var point = new kakao.maps.LatLng(points[k][1], points[k][0]);
                path.push(point);
            }

            paths.push(path);
        }

        var fillColor = colors[i % colors.length];

        var polygon = new kakao.maps.Polygon({
            map: map,
            path: paths.reduce(function (a, b) {
                return a.concat(b);
            }),
            strokeWeight: 1,
            strokeColor: '#000000',
            strokeOpacity: 0.8,
            strokeStyle: 'solid',
            fillColor: fillColor,
            fillOpacity: 0.8
        });

        kakao.maps.event.addListener(polygon, 'click', function () {
            console.log('Polygon clicked:', feature.properties.SIG_KOR_NM);
            fetchDistrictData(feature.properties.SIG_KOR_NM);
            fetchForecastData(feature.properties.SIG_KOR_NM); // 예측 데이터 호출
        });

        kakao.maps.event.addListener(polygon, 'mouseover', function () {
            polygon.setOptions({ fillColor: hoverColor });
        });

        kakao.maps.event.addListener(polygon, 'mouseout', function () {
            polygon.setOptions({ fillColor: fillColor });
        });

        var labelContent = document.createElement('div');
        labelContent.className = 'label';
        labelContent.textContent = feature.properties.SIG_KOR_NM;
        labelContent.style.cursor = 'pointer';

        // HTML content에 클릭 이벤트 추가
        labelContent.addEventListener('click', function() {
            console.log('Label clicked:', feature.properties.SIG_KOR_NM);
            fetchDistrictData(feature.properties.SIG_KOR_NM);
            fetchForecastData(feature.properties.SIG_KOR_NM); // 예측 데이터 호출
        });

        // HTML content에 마우스 오버 이벤트 추가
        labelContent.addEventListener('mouseover', function() {
            polygon.setOptions({ fillColor: hoverColor });
        });

        // HTML content에 마우스 아웃 이벤트 추가
        labelContent.addEventListener('mouseout', function() {
            polygon.setOptions({ fillColor: fillColor });
        });

        var label = new kakao.maps.CustomOverlay({
            position: getPolygonCentroid(geometry.coordinates),
            content: labelContent,
            zIndex: 2
        });

        label.setMap(map);
    })(features[i]);
}





// 레이블 추가 함수 호출
addLabels();

// 전역 변수로 트리맵 인스턴스 선언
var treemapChart;

// 트리맵 초기화 및 렌더링 함수
function initTreemap() {
    var options = {
        series: [{
            data: [
                { x: '서구', y: Math.log(218321 + 1), originalY: 218321, fillColor: '#a1ddae' },
                { x: '유성구', y: Math.log(149321 + 1), originalY: 149321, fillColor: '#69e695' },
                { x: '대덕구', y: Math.log(184321 + 1), originalY: 184321, fillColor: '#74d298' },
                { x: '중구', y: Math.log(255321 + 1), originalY: 255321, fillColor: '#59a576' },
                { x: '동구', y: Math.log(184321 + 1), originalY: 184321, fillColor: '#92e88c' }
            ]
        }],
        chart: {
            height: 300,
            type: 'treemap',
            toolbar: { show: false },
            events: {
                dataPointSelection: function(event, chartContext, config) {
                    var districtName = config.w.config.series[0].data[config.dataPointIndex].x;
                    console.log(districtName); // 클릭된 구 이름 로깅
                    fetchForecastData(districtName);
                    if (chartContext.activeSeriesIndex === -1) return; // 새로고침
																		// 방지 조건
																		// 추가
                    console.log(districtName , "================");
                    var array = ["서구", "중구","대덕구","유성구","동구"];
	                for (var i = 0; i < array.length; i++) {
	                    if (array[i].includes(districtName)) {
	                        fetchDistrictData(districtName);
	                        fetchForecastData(districtName); // 예측 데이터 호출
	                    }
	                }
                }
            }
        },
        title: {
            text: '대전광역시 아파트 전력량 현황',
            align: 'left',
            margin: 0,
            style: {
                fontSize: '18px',
                color: '#333'
            }
        },
        tooltip: {
            theme: 'dark',
            style: {
                fontSize: '12px'
            },
            x: { show: true },
            y: {
                formatter: function (val, opts) {
                    var originalY = opts.w.config.series[opts.seriesIndex].data[opts.dataPointIndex].originalY;
                    return originalY.toLocaleString() + ' kWh';
                }
            }
        },
        plotOptions: {
            treemap: {
                distributed: true,
                enableShades: false
            }
        }
    };

    treemapChart = new ApexCharts(document.querySelector("#treemap"), options);
    treemapChart.render();
}

// AJAX 요청 함수
function fetchDistrictData(districtName) {
    $.ajax({
        url: '/aptGetDistrict',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ apartDistrict: districtName }),
        success: function(data) {
            updateTreemap(data);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ', status, error);
        }
    });
}

// 데이터 업데이트 함수
function updateTreemap(data) {
    var newData = data.map(item => ({
        x: item.apartNeighborhood,
        y: Math.log(item.totalElecUsage + 1), // 로그 스케일 적용, 0을 피하기 위해 1을 더함
        originalY: item.totalElecUsage, // 원본 데이터 저장
        fillColor: getRandomGreenColor()
    }));

    // 차트 업데이트만 실행하고 새로 생성하지 않음
    treemapChart.updateSeries([{ data: newData }]);
}

// 클릭 이벤트를 처리하는 로직
function initTreemapClickHandling() {
    treemapChart.chart.on('dataPointSelection', (event, chartContext, config) => {
        var districtName = config.w.config.series[0].data[config.dataPointIndex].x;
        fetchDistrictData(districtName); // 데이터 가져오기
        event.stopPropagation(); // 다른 이벤트 처리기가 이 이벤트를 받지 못하도록 중단
    });
}

// 초록색 계열의 랜덤 색상 생성 함수
function getRandomGreenColor() {
    var r = Math.floor(Math.random() * 100);  // 빨간색은 매우 낮게
    var g = Math.floor(Math.random() * 156) + 100;  // 초록색은 중간에서 높은 범위로
    var b = Math.floor(Math.random() * 100);  // 파란색은 매우 낮게

    // 16진수로 변환
    var red = r.toString(16);
    var green = g.toString(16);
    var blue = b.toString(16);

    // 한 자리 수일 경우 앞에 '0'을 추가
    red = red.length === 1 ? '0' + red : red;
    green = green.length === 1 ? '0' + green : green;
    blue = blue.length === 1 ? '0' + blue : blue;

    return `#${red}${green}${blue}`;
}

// 트리맵 초기화 호출
initTreemap();

// 예측 그래프 초기화
var forecastOptions = {
    series: [{
        name: '전력량',
        type: 'column',
        data: []
    }, {
        name: '탄소 배출량',
        type: 'line',
        data: []
    }],
    chart: {
        height: 300,
        type: 'line',
        stacked: false,
        toolbar: {
            show: false // 차트 툴바 비활성화
        },
        zoom: {
            enabled: false  // 줌 기능 비활성화
        },
        brush: {
            enabled: false  // 브러시 기능 비활성화
        },
        selection: {
            enabled: false  // 선택 기능 비활성화
        }
    },
    title: {
        text: '[세대 평균] 에너지 예측량',
        align: 'center',  // 제목을 가운데 정렬
        margin: 10,  // 제목과 차트 컨텐츠 사이의 여백
        style: {
            fontSize: '16px',
            fontWeight: 'bold',
            color: '#263238'  // 제목의 글꼴 색상
        }
    },
    stroke: {
        width: [0, 4]  // 막대의 굵기 0, 선의 굵기 4
    },
    xaxis: {
        categories: [],
        labels: {
            style: {
                colors: 'black'
            }
        }
    },
    yaxis: [{
        axisTicks: {
            show: true,
        },
        axisBorder: {
            show: true,
            color: 'black'
        },
        tickAmount: 3  // y축 간격을 3 단위로 설정
    }, {
        opposite: true,
        axisTicks: {
            show: true,
        },
        axisBorder: {
            show: true,
            color: 'black'
        },
        labels: {
            style: {
                colors: '#00E396',
            }
        }
    }],
    tooltip: {
        enabled: false // 툴팁 비활성화
    },
    legend: {
        show: true
    },
    dataLabels: {
        enabled: true,
        enabledOnSeries: [0, 1],
        style: {
            fontSize: '12px',
            colors: ['#59a576']
        },
        background: {
            enabled: true,
            foreColor: '#ffffff',
            padding: 4
        }
    },
    grid: {
        borderColor: '#000000'
    },
    colors: ['#48f8fe', '#0b7e20'] // 막대는 하늘색, 선은 녹색
};

var forecastChart = new ApexCharts(document.querySelector("#chart"), forecastOptions);
forecastChart.render();



// 차트 업데이트 함수
function updateChart(chart, response) {
    var categories = [];
    var data = [];

    // 응답 데이터를 이용해 카테고리 및 데이터 배열 채우기
    response.forEach(function(item) {
        categories.push(formatDate(item.enerDt)); // 날짜 형식 변환
        data.push(item.elecUsage); // 데이터는 숫자 형식 변환 없이 그대로 추가
    });

    // 차트 업데이트
    chart.updateOptions({
        xaxis: {
            categories: categories
        }
    });

    chart.updateSeries([{
        name: '전력 사용량 [kwh]',
        data: data
    }]);
}

// 전력량 차트
var options = {
    series: [{
        name: '전력 사용량 [kwh]',
        data: []
    }],
    chart: {
        type: 'bar',
        height: '100%',
        toolbar: {
            show: false
        }
    },
    colors: ['#92e88c'], // 전체 차트의 색상을 여기서 설정
    plotOptions: {
        bar: {
            borderRadius: 4,
            horizontal: false
        }
    },
    dataLabels: {
        enabled: true,
        formatter: function (val) {
            return formatNumber(Math.round(val)); // 숫자 사이에 쉼표 추가
        },
        style: {
            colors: ['#000000'] // 데이터 레이블의 색상을 검은색으로 변경
        }
    },
    title: {
        text: '대전광역시 아파트 사용 전력량', // 타이틀 텍스트
        align: 'center', // 타이틀 정렬 (left, center, right)
        style: {
            fontSize: '18px',
            color: '#263238'
        }
    },
    xaxis: {
        categories: [],
        labels: {
            style: {
                colors: 'black'
            }
        }
    },
    yaxis: {
        labels: {
            style: {
                colors: 'black'
            },
            formatter: function (val) {
                return formatNumber(val); // y축 레이블에 숫자 사이에 쉼표 추가
            }
        }
    },
    tooltip: {
        enabled: true,
        theme: 'dark',
        style: {
            backgroundColor: 'black',
            fontSize: '12px',
            fontFamily: undefined
        },
        y: {
            formatter: function (val) {
                return formatNumber(val); // 툴팁에 숫자 사이에 쉼표 추가
            }
        }
    },
    grid: {
        borderColor: '#000000'
    }
};

var chart = new ApexCharts(document.querySelector("#apexchart"), options);
chart.render();

// 데이터 가져오기 및 차트 업데이트
fetchData(function(error, response) {
    if (error) {
        console.error("데이터를 가져오는데 실패했습니다:", error);
    } else {
        updateChart(chart, response);
    }
});



//숫자 사이에 쉼표를 추가하는 함수
function formatNumber(num) {
 return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

//날짜 형식을 변환하는 함수 (예: 202301 -> 2023-01)
function formatDate(enerDt) {
 var year = enerDt.substring(0, 4);
 var month = enerDt.substring(4, 6);
 return year + '-' + month;
}

//AJAX 요청을 보내 데이터를 가져오는 함수
function fetchData(callback) {
 $.ajax({
     url: '/aptGetSum',
     method: 'POST',
     contentType: 'application/json',
     success: function(response) {
         callback(null, response);
     },
     error: function(error) {
         callback(error);
     }
 });
}

// Ajax로 Flask에 예측치 요청 
function fetchForecastData(districtName) {
    $.ajax({
        url: 'http://192.168.0.16:5555/forecast',  // Flask 서버의 URL
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({ location: districtName }),
        success: function(data) {
            console.log('Received data:', data);

            // 현재 날짜를 기준으로 이번달과 다음달의 날짜를 계산
            const now = new Date();
            const currentYear = now.getFullYear();
            const currentMonth = now.getMonth() + 1; // getMonth()는 0부터 시작하므로 +1

            // 이번달과 다음달의 키 설정
            const currentMonthKey = `${currentYear}-${currentMonth.toString().padStart(2, '0')}-01`;
            const nextMonthKey = `${currentYear}-${(currentMonth + 1).toString().padStart(2, '0')}-01`;

            // 데이터가 존재하지 않는 경우 기본값 설정
            const currentMonthData = data.forecast[currentMonthKey] || 0;
            const nextMonthData = data.forecast[nextMonthKey] || 0;

            // 탄소 배출량 계산 (예: 1 kWh당 0.4 kg CO2)
            const emissionFactor = 0.4;
            const currentMonthEmission = Math.round(currentMonthData * emissionFactor);
            const nextMonthEmission = Math.round(nextMonthData * emissionFactor);

            console.log('Available keys in forecast:', Object.keys(data.forecast));
            console.log('Current month key:', currentMonthKey);
            console.log('Next month key:', nextMonthKey);
            console.log('Current month data:', currentMonthData);
            console.log('Next month data:', nextMonthData);
            console.log('Current month emission:', currentMonthEmission);
            console.log('Next month emission:', nextMonthEmission);

            // 데이터로 차트 업데이트
            const categories = [`${currentMonth}월`, `${currentMonth + 1}월`];
            updateForecastChart(categories, [currentMonthData, nextMonthData], [currentMonthEmission, nextMonthEmission]);
        },
        error: function(xhr, status, error) {
            console.error('Error fetching data: ', status, error);
        }
    });
}

//예측 차트 업데이트 함수
function updateForecastChart(categories, usageData, emissionData) {
    forecastChart.updateOptions({
        xaxis: {
            categories: categories
        }
    });

    forecastChart.updateSeries([{
        name: '전력량',
        type: 'column',
        data: usageData
    }, {
        name: '탄소 배출량',
        type: 'line',
        data: emissionData
    }]);
}

//초기 상태에서 대전광역시 전체 데이터 가져오기
fetchForecastData(null); // null을 전달하여 대전광역시 전체 데이터를 가져오도록 설정