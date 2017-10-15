Graphics = {}

function Graphics.rectangle(x1, y1, width, height, r, g, b, alpha)
	DrawRect(x1, y1, width, height, r, g, b, alpha)
end


function Graphics.text_rgba(text, x, y, size, r, g, b, a)
	SetTextFont(0);
	SetTextScale(size, size);
	SetTextColour(r, g, b, a);
	SetTextCentre(true);
	SetTextDropShadow(0, 0, 0, 0, 0);
	SetTextEdge(0, 0, 0, 0, 0);
	SetTextEntry("STRING");
	AddTextComponentString(text);
	DrawText(x, y);
end

function Graphics.text(text, x, y, size)
	Graphics.text_rgba(text, x, y, size, 255, 255, 255, 255)
end

function Graphics.ClearDrawOrigin()
	ClearDrawOrigin()
end

function Graphics.SetDrawOrigin(x, y, z)
	SetDrawOrigin(x, y, z, 0);
end


function Graphics.DrawMarker(type, x, y, z, h, rx, ry, rz, scalex, scaley, scalez, r, g, b, alpha, bob, facecamera, drawonents)
	DrawMarker(type, x, y, z, 0, 0, 0, rx, ry, rz, scalex, scaley, scalez, r, g, b, alpha, bob, facecamera, 1, true, 0, 0, drawonents)
end

