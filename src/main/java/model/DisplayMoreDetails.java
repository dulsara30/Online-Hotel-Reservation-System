package model;

public class DisplayMoreDetails {
	
	
	private int roomId;
	private int hotelId;
	private String roomImage;
	private String hotelImage;
	private String hotelName;
	private String location;
	private String roomType;
	private String fullBR;
	private String halfBR;
	private String facilities;
	
	
	
	
	
	
	public DisplayMoreDetails() {
	
	}
	public DisplayMoreDetails(int roomId, int hotelId, String roomImage, String hotelImage, String hotelName, String location, String roomType, String fullBR, String halfBR, String facilities) {
	
		this.roomId = roomId;
		this.hotelId = hotelId;
		this.roomImage = roomImage;
		this.hotelImage = hotelImage;
		this.hotelName = hotelName;
		this.location = location;
		this.roomType = roomType;
		this.fullBR = fullBR;
		this.halfBR = halfBR;
		this.facilities = facilities;
	}
	public int getRoomId() {
		return roomId;
	}

	public int getHotelId() {
		return hotelId;
	}

	public String getRoomImage() {
		return roomImage;
	}

	public String getHotelImage() {
		return hotelImage;
	}

	public String getHotelName() {
		return hotelName;
	}

	public String getLocation() {
		return location;
	}

	public String getRoomType() {
		return roomType;
	}

	public String getFullBR() {
		return fullBR;
	}

	public String getHalfBR() {
		return halfBR;
	}

	public String getFacilities() {
		return facilities;
	}

	
	

}
