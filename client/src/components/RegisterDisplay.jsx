import { useEffect, useState } from "react";

const RegisterDisplay = ({ register }) => {
  const [resolvedData, setResolvedData] = useState(null);

  useEffect(() => {
    const loadData = async () => {
      if (register?.responseObject?.data instanceof Promise) {
        const result = await register.responseObject.data;
        setResolvedData(result);
      } else {
        setResolvedData(register?.responseObject?.data || null);
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
    <div>
      <h3>Resolved Event Data:</h3>
      <pre>{JSON.stringify(resolvedData, null, 2)}</pre>
    </div>
  );
}

export default RegisterDisplay;
