# include "ut_log.h"
# include "ut_mysql.h"

MYSQL *mysql_connect(mysql_cfg *cfg)
{
    MYSQL *conn = mysql_init(NULL);
    if (conn == NULL)
        return NULL;

    // 设置字符集
    if (mysql_options(conn, MYSQL_SET_CHARSET_NAME, cfg->charset) != 0) {
        mysql_close(conn);
        return NULL;
    }

    // 设置连接超时
    unsigned int timeout = 10;
    if (mysql_options(conn, MYSQL_OPT_CONNECT_TIMEOUT, &timeout) != 0) {
        mysql_close(conn);
        return NULL;
    }

    // 设置读写超时
    unsigned int read_timeout = 10;
    unsigned int write_timeout = 10;
    mysql_options(conn, MYSQL_OPT_READ_TIMEOUT, &read_timeout);
    mysql_options(conn, MYSQL_OPT_WRITE_TIMEOUT, &write_timeout);

    // 移除废弃的重连选项，直接在建立连接时处理
    if (mysql_real_connect(conn, cfg->host, cfg->user, cfg->pass, cfg->name, cfg->port, NULL, 
        CLIENT_MULTI_STATEMENTS | CLIENT_REMEMBER_OPTIONS) == NULL) {
        mysql_close(conn);
        return NULL;
    }

    // 不再使用 MYSQL_OPT_RECONNECT
    // 改用应用层面处理重连逻辑

    return conn;
}

bool is_table_exists(MYSQL *conn, const char *table)
{
    sds sql = sdsempty();
    sql = sdscatprintf(sql, "SHOW TABLES LIKE '%s'", table);
    log_trace("exec sql: %s", sql);
    int ret = mysql_real_query(conn, sql, sdslen(sql));
    if (ret < 0) {
        log_error("exec sql: %s fail: %d %s", sql, mysql_errno(conn), mysql_error(conn));
        sdsfree(sql);
        return false;
    }
    sdsfree(sql);

    MYSQL_RES *result = mysql_store_result(conn);
    size_t num_rows = mysql_num_rows(result);
    mysql_free_result(result);
    if (num_rows == 1)
        return true;

    return false;
}

