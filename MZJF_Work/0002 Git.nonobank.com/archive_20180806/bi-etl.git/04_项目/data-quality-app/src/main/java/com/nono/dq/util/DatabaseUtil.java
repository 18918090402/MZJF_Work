/*! ******************************************************************************
 *
 * Pentaho Data Integration
 *
 * Copyright (C) 2002-2013 by Pentaho : http://www.pentaho.com
 *
 *******************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 ******************************************************************************/

package com.nono.dq.util;

import java.sql.Connection;
import java.sql.Statement;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.sql.DataSource;

/**
 * Provides default implementation for looking data sources up in JNDI.
 *
 * @author mbatchel
 */

public class DatabaseUtil {
  private static Map<String, DataSource> FoundDS = Collections.synchronizedMap( new HashMap<String, DataSource>() );

  /**
   * Clears cache of DataSources (For Unit test)
   */
  protected static void clearDSCache() {
    FoundDS.clear();
  }


  public static void closeSilently( Connection[] connections ) {
    if ( connections == null || connections.length == 0 ) {
      return;
    }
    for ( Connection conn : connections ) {
      closeSilently( conn );
    }
  }

  public static void closeSilently( Connection conn ) {
    if ( conn == null ) {
      return;
    }
    try {
      conn.close();
    } catch ( Throwable e ) {
      // omit
    }
  }

  public static void closeSilently( Statement[] statements ) {
    if ( statements == null || statements.length == 0 ) {
      return;
    }
    for ( Statement st : statements ) {
      closeSilently( st );
    }
  }

  public static void closeSilently( Statement st ) {
    if ( st == null ) {
      return;
    }
    try {
      st.close();
    } catch ( Throwable e ) {
      // omit
    }
  }
}
