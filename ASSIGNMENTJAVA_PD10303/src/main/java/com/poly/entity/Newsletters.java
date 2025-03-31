package com.poly.entity;

public class Newsletters {
	private String email;
	private boolean enabled;

	public Newsletters() {
		super();
	}

	public Newsletters(String email, boolean enabled) {
		super();
		this.email = email;
		this.enabled = enabled;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	@Override
	public String toString() {
		return "Newsletters [email=" + email + ", enabled=" + enabled + "]";
	}

}
