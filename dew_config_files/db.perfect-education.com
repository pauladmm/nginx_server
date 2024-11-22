
; BIND data file for locoal loopback interface
;
$TTL	6048000
@	IN	SOA	perfect-education.com. admin-perfect.education.com. (
			2024112201	; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800	)	; Negative Cache TTL

@	IN	NS	perfect-education.com.
perfect-education.com.	IN	A	192.168.56.10
www.perfect-education.com.	IN	A	192.168.56.10
