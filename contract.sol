pragma experimental ABIEncoderV2;

contract adsContract {
    event Creation(address from, string vin);

    event Transfer(address from, address to, string vin);

    struct ads {
        string title;
        string description;
        string phone;
        string mobile;
        string img;
        string location_text;
        string map_link;
        string face;
        string inst;
        string vin;
        address owner;
    }

    mapping(string => ads) adss;
    string[] public collesctads;
    address public owner = msg.sender;
    uint256 public creationTime = now;

    constructor() public {
        createAds(
            "0798347090",
            "مقهى صوفيا الدولي",
            "خدماتنا: صالة للعب و متابعة المباريات ، مشروبات ساخنة و باردة ، أراجيل",
            "tel:0798347090",
            "tel:0798347090",
            "https://s3.us-east-2.amazonaws.com/delnee.customers/985e079241e91e9f3c27287122b3b8bce169d3cd.jpeg",
            "عمان, خلدا, شارع وصفي التل - مجمع كرادشة خريطة الموقع",
            "https://www.google.com/maps/search/?api=1&query=31.9952654,35.8571781",
            "https://web.facebook.com/Sofia-Caf%C3%A9-%D9%85%D9%8E%D9%82%D9%87%D9%89%D9%92-%D8%B5%D9%8F%D9%88%D9%81%D9%8A%D8%A7-763518513754583/",
            "https://web.facebook.com/Sofia-Caf%C3%A9-%D9%85%D9%8E%D9%82%D9%87%D9%89%D9%92-%D8%B5%D9%8F%D9%88%D9%81%D9%8A%D8%A7-763518513754583/"
        );
        createAds(
            "tel:0796984886",
            "قهوة وسط المدينة",
            "خدماتنا: قهوة تركية ، قهوة عربية",
            "tel:0796984886",
            "tel:0796984886",
            "https://s3.us-east-2.amazonaws.com/delnee.customers/3b779767a20725a5dee574b7766353d478d927df.jpg",
            "عمان, خلدا, دوار السكر - مجمع البوز سنترخريطة الموقع",
            "https://www.google.com/maps/search/?api=1&query=31.9899673,35.8491237",
            "https://web.facebook.com/ammancoffeedowntown/",
            "https://web.facebook.com/ammancoffeedowntown/"
        );
        createAds(
            "tel:0790860101",
            "ابو خلدون كباتيلو - الصويفية",
            "خدماتنا:نقدم لكم جميع أنواع البهارات و الزعتر ، زيوت متعددة ، عسل ، تمور عدة أصناف ، طحن البهارات و مزجها طازجة امامك ، عطارة",
            "tel:0790860101",
            "tel:0790860101",
            "https://s3.us-east-2.amazonaws.com/delnee.customers/150e3c0516cae718d2c5038431fc08d2cac6c37d.jpg",
            "عمان, الصويفية, شارع محمود عبيدات - تقاطع السفراءخريطة الموقع",
            "https://www.google.com/maps/search/?api=1&query=31.958315599098643,35.865145434213105",
            "https://web.facebook.com/%D9%83%D8%A8%D8%A7%D8%AA%D9%8A%D9%84%D9%88-%D8%A7%D8%A8%D9%88-%D8%AE%D9%84%D8%AF%D9%88%D9%86-Kabatilo-1647565732128160/",
            "https://web.facebook.com/%D9%83%D8%A8%D8%A7%D8%AA%D9%8A%D9%84%D9%88-%D8%A7%D8%A8%D9%88-%D8%AE%D9%84%D8%AF%D9%88%D9%86-Kabatilo-1647565732128160/"
        );
    }

    modifier onlyBy(address _account) {
        require(msg.sender == _account, "Sender not authorized.");
        _;
    }

    function changeOwner(address _newOwner) public onlyBy(owner) {
        owner = _newOwner;
    }

    /**
     * Creates a track record of a new Ads.
     * Transaction will fail (and burn gas!) if the Ads already exists.
     */
    function createAds(
        string vin,
        string title,
        string description,
        string phone,
        string mobile,
        string img,
        string location_text,
        string map_link,
        string face,
        string inst
    ) public {
        assert(adss[vin].owner == 0x0);
        adss[vin].vin = vin;
        adss[vin].owner = msg.sender;
        adss[vin].title = title;
        adss[vin].description = description;
        adss[vin].phone = phone;
        adss[vin].mobile = mobile;
        adss[vin].img = img;
        adss[vin].location_text = location_text;
        adss[vin].map_link = map_link;
        adss[vin].face = face;
        adss[vin].inst = inst;
        collesctads.push(vin);
        emit Creation(msg.sender, vin);
    }

    function transferOwnership(string vin, address _owner) public {
        ads storage transferObject = adss[vin];
        assert(transferObject.owner == msg.sender);
        transferObject.owner = _owner;
        emit Transfer(msg.sender, _owner, vin);
    }

    /**
     * Returns the current data of the given Ads
     */
    function getAds(string vin) public view returns (ads memory) {
        return adss[vin];
    }

    function getAdss() public view returns (ads[] memory) {
        ads[] memory addss = new ads[](collesctads.length);
        for (uint256 i = 0; i < collesctads.length; i++) {
            addss[i] = adss[collesctads[i]];
        }
        return addss;
    }
}
