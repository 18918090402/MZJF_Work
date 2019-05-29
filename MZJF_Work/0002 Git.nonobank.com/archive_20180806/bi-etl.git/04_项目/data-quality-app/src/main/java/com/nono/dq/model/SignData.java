package com.nono.dq.model;
public class SignData {

		private final String accessId;
		private final String signature;

		public SignData(final String accessId, final String signature) {

			this.accessId = accessId;
			this.signature = signature;
		}

		public String getAccessId() {

			return this.accessId;
		}

		public String getSignature() {

			return this.signature;
		}

		@Override
		public String toString() {
			return "SignData [accessId=" + accessId + ", signature=" + signature + "]";
		}
		
	}