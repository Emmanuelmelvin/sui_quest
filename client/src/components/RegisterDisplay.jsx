import { useEffect, useState } from "react";

function RegisterDisplay({ register }) {
  const [resolvedData, setResolvedData] = useState([]);

  useEffect(() => {
    const loadData = async () => {
      if (
        register?.responseObject?.data &&
        register.responseObject.data instanceof Promise
      ) {
        const result = await register.responseObject.data;
        setResolvedData(result);
      } else {
        setResolvedData(register?.responseObject?.data || []);
      }
    };

    loadData();
  }, [register]);

  if (!register?.requestSent) {
    return <div>{register?.message || "No request sent"}</div>;
  }

  if (register.responseObject?.isPending) {
    return <div>Loading...</div>;
  }

  if (register.responseObject?.isError) {
    return <div>Error: {register.responseObject.error.message}</div>;
  }

  return (
    <div style={{ padding: "20px", fontFamily: "Arial, sans-serif", backgroundColor: "#f4f4f9" }}>
      {resolvedData.map((eventObj, idx) => {
        const event = eventObj.data?.content?.fields;
        if (!event) return null;

        return (
          <div key={idx} style={{
            backgroundColor: "#fff",
            borderRadius: "8px",
            padding: "20px",
            marginBottom: "20px",
            boxShadow: "0 2px 5px rgba(0,0,0,0.1)"
          }}>
            <div style={{ fontSize: "1.5em", marginBottom: "10px", color: "#4a90e2" }}>
              {event.name}
            </div>
            <div style={{ fontWeight: "bold", color: event.has_ended ? "red" : "green" }}>
              Status: {event.has_ended ? "Ended" : "Active"}
            </div>
            <div style={{ fontSize: "0.9em", color: "#666", marginBottom: "15px" }}>
              Organizer: {event.organizers}
            </div>

            <div>
              <div style={{ fontWeight: "bold", marginBottom: "5px" }}>Quests:</div>
              {event.quests.map((quest, qIdx) => (
                <div key={qIdx} style={{
                  borderTop: "1px solid #ddd",
                  paddingTop: "10px",
                  marginTop: "10px"
                }}>
                  <div style={{ fontWeight: "bold", fontSize: "1.1em" }}>{quest.fields.name}</div>
                  <div>Tasks: {quest.fields.task_count}</div>
                  <div>Duration: {quest.fields.duration_sec} seconds</div>
                  <div style={{ color: "#888" }}>
                    Status: {quest.fields.is_started ? "Started" : "Not Started"}
                  </div>
                </div>
              ))}
            </div>
          </div>
        );
      })}
    </div>
  );
}

export default RegisterDisplay;
