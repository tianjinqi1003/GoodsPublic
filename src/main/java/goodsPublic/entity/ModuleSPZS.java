package goodsPublic.entity;

import java.io.Serializable;

public class ModuleSPZS implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final String RED_WINE="redWine";
	public static final String WHITE_WINE="whiteWine";
	public static final String HOME_TEXTILES="homeTextiles";
	public static final String ARTWORK="artwork";
	private int id;
	private String name;
	private String value;
	private String type;
	private int sort;
	private String moduleName;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public int getSort() {
		return sort;
	}
	public void setSort(int sort) {
		this.sort = sort;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	
}
