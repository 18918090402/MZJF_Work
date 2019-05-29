package com.nono.dq.app.config;

import java.io.Serializable;
import java.util.Locale;

import org.hibernate.boot.model.naming.Identifier;
import org.hibernate.boot.model.naming.PhysicalNamingStrategyStandardImpl;
import org.hibernate.engine.jdbc.env.spi.JdbcEnvironment;

public class RealNamingStrategyImpl extends org.springframework.boot.orm.jpa.hibernate.SpringPhysicalNamingStrategy implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public static final PhysicalNamingStrategyStandardImpl INSTANCE = new PhysicalNamingStrategyStandardImpl();

	/**
	 * 表名转换成大写
	 */
    @Override
    public Identifier toPhysicalTableName(Identifier name, JdbcEnvironment context) {
        return toUpperCase(name);
    }
    
    private boolean isUnderscoreRequired(char before, char current, char after) {
		return Character.isLowerCase(before) && Character.isUpperCase(current)
				&& Character.isLowerCase(after);
	}
    
    private Identifier toUpperCase(Identifier name) {
		if (name == null) {
			return null;
		}
		StringBuilder text = new StringBuilder(name.getText().replace('.', '_'));
		for (int i = 1; i < text.length() - 1; i++) {
			if (isUnderscoreRequired(text.charAt(i - 1), text.charAt(i),
					text.charAt(i + 1))) {
				text.insert(i++, '_');
			}
		}
		return new Identifier(text.toString().toUpperCase(Locale.ROOT), name.isQuoted());
	}

}